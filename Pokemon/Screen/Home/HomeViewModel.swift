//
//  HomeViewModel.swift
//  Pokemon
//
//  Created by Adriano Rezena on 20/05/23.
//

import DomainLayer
import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var species: [Species] { get set }
    var fetchError: String? { get set }
    func fetchSpecies(completion: @escaping () -> Void)
}

final class HomeViewModel: HomeViewModelProtocol {
    var isFetching: Bool = false
    var species: [Species] = []
    var fetchError: String?
    var limit: Int = 30
    var offset: Int = 0
    
    let pokemonUseCase: PokemonListUseCaseProtocol
    
    init(pokemonUseCase: PokemonListUseCaseProtocol) {
        self.pokemonUseCase = pokemonUseCase
    }
    
    func fetchSpecies(completion: @escaping () -> Void) {
        Task {
            let response = await pokemonUseCase.fetchSpecies(limit: limit, offset: offset)
            
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
