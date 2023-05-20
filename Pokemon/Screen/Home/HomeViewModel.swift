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
    
    func fetchSpecies(completion: @escaping () -> Void) {
        let useCase = ListPokemonUseCase(pokemonRepository: PokemonRepository())
        
        Task {
            let response = await useCase.fetchSpecies(limit: 100, offset: 0)
            
            DispatchQueue.main.async {
                switch response {
                case .success(let species):
                    self.species = species
                    
                case .failure(let failure):
                    self.fetchError = failure.localizedDescription
                }
                
                completion()
            }
        }
    }
}
