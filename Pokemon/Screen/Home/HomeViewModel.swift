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
                    
                    if let nextPage: String = speciesList.next, let pagination = self?.getLimitOffset(nextPage) {
                        self?.limit = pagination.limit
                        self?.offset = pagination.offset
                    }
                    
                case .failure(let failure):
                    self?.fetchError = failure.localizedDescription
                }
                
                completion()
            }
        }
    }
    
    private func getLimitOffset(_ urlString: String) -> (limit: Int, offset: Int)? {
        guard
            let url = URL(string: urlString),
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
        else {
            return nil
        }
    
        // TODO: move this logic to the object mapping and return as a new property
        let limit = Int(queryItems.first(where: { $0.name == "limit" })?.value ?? "0") ?? 0
        let offset = Int(queryItems.first(where: { $0.name == "offset" })?.value ?? "0") ?? 0
        
        return (limit, offset)
    }
}
