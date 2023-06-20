//
//  PokemonFavoriteUseCaseTests.swift
//  
//
//  Created by Adriano Rezena on 18/06/23.
//

@testable import DomainLayer
import XCTest

final class PokemonFavoriteUseCaseTests: XCTestCase {

    // MARK: - addFavorite
    func test_addFavorite_succesfullyAddSpecies() async throws {
        let expectedResult: [Species] = [makeSpecies()]
        let (sut, repository) = makeSUT()
        
        try await sut.addFavorite(species: makeSpecies())
        XCTAssertEqual(expectedResult, repository.favorites)
    }
    
    func test_addFavorite_failsOnRepositoryException() async throws {
        let (sut, repository) = makeSUT()
        repository.shouldFail = true
        
        do {
            try await sut.addFavorite(species: makeSpecies())
            XCTFail("Should have failed")
        } catch {
            XCTAssertEqual(error as NSError, anyNSError())
        }
    }

    // MARK: - removeFavorite
    func test_removeFavorite_succesfullyRemoveSpecies() async throws {
        let expectedResult: [Species] = []
        let (sut, repository) = makeSUT()
        
        let species = makeSpecies()
        repository.favorites = [species]
        
        try await sut.removeFavorite(species: species)
        XCTAssertEqual(expectedResult, [])
    }
    
    func test_removeFavorite_succeedIfSpeciesNotFavorited() async throws {
        let (sut, _) = makeSUT()

        do {
            try await sut.removeFavorite(species: makeSpecies())
        } catch {
            XCTFail("Expected success, got \(error) instead")
        }
    }

    func test_removeFavorite_failsOnRepositoryException() async throws {
        let (sut, repository) = makeSUT()
        repository.shouldFail = true
        
        do {
            try await sut.removeFavorite(species: makeSpecies())
            XCTFail("Expected failure")
        } catch {
            XCTAssertEqual(error as NSError, anyNSError())
        }
    }
    
    // MARK: - getFavorites
    func test_getFavorites_successfullyReturnFavorites() async {
        let expectedResult: [Species] = [makeSpecies()]
        let (sut, repository) = makeSUT()
        repository.favorites = [makeSpecies()]
        
        let response = await sut.getFavorites()
        
        switch response {
        case .success(let favorites):
            XCTAssertEqual(favorites, expectedResult)
            
        case .failure(let failure):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_getFavorites_failsOnRepositoryException() async {
        let (sut, repository) = makeSUT()
        repository.shouldFail = true
        
        let response = await sut.getFavorites()
        
        switch response {
        case .success(let favorites):
            XCTFail("Expected failure, got \(favorites) instead")
            
        case .failure(let failure):
            XCTAssertEqual(failure as NSError, anyNSError())
        }
    }
}

// MARK: - Helpers
extension PokemonFavoriteUseCaseTests {
    
    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (PokemonFavoriteUseCaseProtocol, FavoriteRepositorySpy) {
        let repository = FavoriteRepositorySpy()
        let sut = PokemonFavoriteUseCase(repository: repository)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(repository, file: file, line: line)
        return (sut, repository)
    }
 
    private func makeSpecies() -> Species {
        Species(name: "Any Species", id: "999", imageURL: anyURLString())
    }
    
    private class FavoriteRepositorySpy: FavoriteRepositoryProtocol {
        var shouldFail: Bool = false
        var favorites: [Species] = []
        
        func addFavorite(species: Species) async throws {
            if shouldFail {
                throw anyNSError()
            }
            
            favorites.append(species)
        }
        
        func removeFavorite(species: Species) async throws {
            if shouldFail {
                throw anyNSError()
            }
            
            favorites.removeAll(where: { $0.id == species.id})
        }
        
        func getFavorites() async -> Result<[Species], Error> {
            if shouldFail {
                return .failure(anyNSError())
            }
            
            return .success(favorites)
        }

    }
}
