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
    func fetchMoreSpecies(completion: @escaping ([Species]) -> Void)
    func addFavorite(species: Species)
//    func removeFavorite(species: Species) async throws
//    func getFavorites() async -> Result<[Species], Error>
}

final class HomeViewModel: HomeViewModelProtocol {
    var isFetching: Bool = false
    var species: [Species] = []
    var fetchError: String?
    var limit: Int = 30
    var offset: Int = 0
    
    let pokemonUseCase: PokemonListUseCaseProtocol
    let favoriteUseCase: PokemonFavoriteUseCaseProtocol
    
    init(
        pokemonUseCase: PokemonListUseCaseProtocol,
        favoriteUseCase: PokemonFavoriteUseCaseProtocol
    ) {
        self.pokemonUseCase = pokemonUseCase
        self.favoriteUseCase = favoriteUseCase
    }
    
    func fetchSpecies(completion: @escaping () -> Void) {
        limit = 30
        offset = 0
        fetchError = ""
        
        Task {
            let response = await pokemonUseCase.fetchSpecies(limit: limit, offset: offset)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch response {
                case .success(let speciesList):
                    self.species = speciesList.results
                    self.limit = speciesList.nextLimit ?? 0
                    self.offset = speciesList.nextOffset ?? 0
                    
                case .failure(let failure):
                    self.fetchError = failure.localizedDescription
                    self.species.removeAll()
                }
                
                completion()
            }
        }
    }
    
    func fetchMoreSpecies(completion: @escaping ([Species]) -> Void) {
        Task {
            let response = await pokemonUseCase.fetchSpecies(limit: limit, offset: offset)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch response {
                case .success(let speciesList):
                    self.species.append(contentsOf: speciesList.results)
                    self.limit = speciesList.nextLimit ?? 0
                    self.offset = speciesList.nextOffset ?? 0
                    completion(speciesList.results)
                    
                case .failure(let failure):
                    self.fetchError = failure.localizedDescription
                    completion([])
                }
                
            }
        }
    }
    
    func addFavorite(species: Species) {
        Task {
            do {
                try await favoriteUseCase.addFavorite(species: species)
            } catch {
                
            }
            
        }
    }
    
}
