//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Adriano Rezena on 21/05/23.
//

import DomainLayer
import Foundation

protocol DetailViewModelProtocol {
    var species: Species { get set }
    func fetchEvolution(completion: @escaping () -> Void)
}

final class DetailViewModel: DetailViewModelProtocol {
    var species: Species
    var evolution: [Species] = []
    var fetchError: String?
    
    let evolutionUseCase: EvolutionPokemonUseCaseProtocol
    
    init(evolutionUseCase: EvolutionPokemonUseCaseProtocol, species: Species) {
        self.evolutionUseCase = evolutionUseCase
        self.species = species
    }
    
    func fetchEvolution(completion: @escaping () -> Void) {
        Task {
            let response = await evolutionUseCase.fetchEvolution(id: species.id)
            
            DispatchQueue.main.async { [weak self] in
                switch response {
                case .success(let species):
                    self?.evolution = species
                    
                case .failure(let failure):
                    self?.fetchError = failure.localizedDescription
                }
                
                completion()
            }
        }
    }
}
