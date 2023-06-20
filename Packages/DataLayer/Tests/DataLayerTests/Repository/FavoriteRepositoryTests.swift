//
//  FavoriteRepositoryTests.swift
//  
//
//  Created by Adriano Rezena on 19/06/23.
//

import DomainLayer
import DataLayer
import XCTest

final class FavoriteRepositoryTests: XCTestCase {
   
    // MARK: - addFavorite
    func test_addFavorite_succesfullyAddFavoriteSpecies() async throws {
        let expectedResult: [Species] = [makeAnySpecies()]
        let (sut, store) = makeSUT()
        try await sut.addFavorite(species: makeAnySpecies())
        XCTAssertEqual(store.favorites, expectedResult)
    }
    
    func test_addFavorite_failsOnDatabaseException() async throws {
        let (sut, store) = makeSUT()
        store.shouldFail = true
        
        do {
            try await sut.addFavorite(species: makeAnySpecies())
            XCTFail("Should have failed")
        } catch {
            XCTAssertEqual(error as NSError, anyNSError())
        }
    }
    
    // MARK: - removeFavorite
    func test_removeFavorite_succesfullyRemoveFavoriteSpecies() async throws {
        let expectedResult: [Species] = []
        let (sut, store) = makeSUT()
        store.favorites = [makeAnySpecies()]
        try await sut.removeFavorite(species: makeAnySpecies())
        XCTAssertEqual(store.favorites, expectedResult)
    }
    
    func test_removeFavorite_succeedIfSpeciesNotFavorited() async throws {
        let (sut, _) = makeSUT()

        do {
            try await sut.removeFavorite(species: makeAnySpecies())
        } catch {
            XCTFail("Expected success, got \(error) instead")
        }
    }
    
    func test_removeFavorite_failsOnDatabaseException() async throws {
        let (sut, store) = makeSUT()
        store.shouldFail = true
        
        do {
            try await sut.removeFavorite(species: makeAnySpecies())
            XCTFail("Should have failed")
        } catch {
            XCTAssertEqual(error as NSError, anyNSError())
        }
    }
    
    // MARK: - getFavorites
    func test_getFavorites_successfullyReturnFavorites() async {
        let expectedResult: [Species] = [makeAnySpecies()]
        let (sut, store) = makeSUT()
        store.favorites = [makeAnySpecies()]
        
        let response = await sut.getFavorites()
        
        switch response {
        case .success(let favorites):
            XCTAssertEqual(favorites, expectedResult)
            
        case .failure(let failure):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_getFavorites_failsOnRepositoryException() async {
        let (sut, store) = makeSUT()
        store.shouldFail = true
        
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
extension FavoriteRepositoryTests {
    
    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (FavoriteRepositoryProtocol, StoreSpy) {
        let store = StoreSpy()
        let sut = FavoriteRepository(speciesStore: store)
        trackForMemoryLeaks(store)
        trackForMemoryLeaks(sut)
        return (sut, store)
    }
    
    private class StoreSpy: SpeciesStore {
        var favorites: [Species] = []
        var shouldFail: Bool = false
        
        func get(id: String) throws -> Species? {
            if shouldFail {
                throw anyNSError()
            }
            
            return nil
        }
        
        func getAll() throws -> [Species] {
            if shouldFail {
                throw anyNSError()
            }
            
            return favorites
        }
        
        func save(_ species: Species) throws {
            if shouldFail {
                throw anyNSError()
            }
            
            self.favorites.append(species)
        }
        
        func delete(_ species: Species) throws {
            if shouldFail {
                throw anyNSError()
            }

            favorites.removeAll(where: { $0.id == species.id})
        }
    }

    private func makeAnySpecies() -> Species {
        Species(name: "Any Species", id: "999", imageURL: anyURL().absoluteString)
    }
    
}
