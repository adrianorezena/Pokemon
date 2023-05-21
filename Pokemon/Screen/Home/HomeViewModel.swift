//
//  HomeViewModel.swift
//  Pokemon
//
//  Created by Adriano Rezena on 20/05/23.
//

import DataLayer // TODO: Move to Coordinator
import DomainLayer
import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var species: [SpeciesList.Species] { get set }
    func fetchSpecies(completion: @escaping () -> Void)
}

final class HomeViewModel: HomeViewModelProtocol {
    var isFetching: Bool = false
    var species: [SpeciesList.Species] = []
    var fetchError: String?
    var limit: Int = 30
    var offset: Int = 0
    
    func fetchSpecies(completion: @escaping () -> Void) {
        let useCase = ListPokemonUseCase(pokemonRepository: PokemonRepository())
        
        Task {
            let response = await useCase.fetchSpecies(limit: limit, offset: offset)
            
            DispatchQueue.main.async { [weak self] in
                switch response {
                case .success(let speciesList):
                    if self?.offset == 0 {
                        self?.species = speciesList.results
                    } else {
                        self?.species.append(contentsOf: speciesList.results)
                    }

                    self?.limit = speciesList.nextLimit ?? 0
                    self?.offset = speciesList.nextOffset ?? 0
                    
                case .failure(let failure):
                    self?.fetchError = failure.localizedDescription
                }
                
                completion()
            }
        }
    }
}
