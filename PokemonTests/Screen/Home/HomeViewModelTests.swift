//
//  HomeViewModelTests.swift
//  PokemonTests
//
//  Created by Adriano Rezena on 22/06/23.
//

import DomainLayer
@testable import Pokemon
import XCTest

final class HomeViewModelTests: XCTestCase {

    func test_init_speciesIsEmpty() throws {
        let sut = makeSUT()
        XCTAssertEqual(sut.species, [])
    }

}

// MARK: - Helpers
extension HomeViewModelTests {
    
    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> HomeViewModelProtocol {
        let useCase = PokemonListUseCaseMock()
        let favoriteUseCase = PokemonFavoriteUseCaseMock()
        let vm = HomeViewModel(pokemonUseCase: useCase, favoriteUseCase: favoriteUseCase)
        
        trackForMemoryLeaks(vm)
        
        return vm
    }
    
    private class PokemonListUseCaseMock: PokemonListUseCaseProtocol {
        func fetchSpecies(limit: Int, offset: Int) async -> Result<SpeciesList, Error> {
            .success(SpeciesList(count: 1, nextLimit: 0, nextOffset: 0, results: []))
        }
    }
    
    private class PokemonFavoriteUseCaseMock: PokemonFavoriteUseCaseProtocol {
        func addFavorite(species: Species) async throws {
            
        }
        
        func removeFavorite(species: Species) async throws {
            
        }
        
        func getFavorites() async -> Result<[Species], Error> {
            .success([])
        }
    }
    
}
