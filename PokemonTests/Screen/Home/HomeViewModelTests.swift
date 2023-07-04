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
    
    func test_init_varsAreEmpty() throws {
        let (sut, _, _) = makeSUT()
        XCTAssertEqual(sut.species, [])
        XCTAssertEqual(sut.fetchError, nil)
    }
    
    func test_fetchSpecies_returns_species() {
        let expectedResult: SpeciesList = SpeciesList(count: 1, nextLimit: 1, nextOffset: 2, results: [])
        let (sut, listUseCase, _) = makeSUT()
        listUseCase.response = .success(expectedResult)
        
        let expectation: XCTestExpectation = XCTestExpectation(description: "wait for response")
        sut.fetchSpecies(completion: {
            expectation.fulfill()
            XCTAssertTrue(Thread.isMainThread)
        })
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(sut.species, expectedResult.results)
        XCTAssertEqual(sut.limit, expectedResult.nextLimit)
        XCTAssertEqual(sut.offset, expectedResult.nextOffset)
    }
    
    func test_fetchSpecies_set_fetchError_on_error() {
        let expectedResult: String = anyNSError().localizedDescription
        let (sut, listUseCase, _) = makeSUT()
        listUseCase.response = .failure(anyNSError())
        
        let expectation: XCTestExpectation = XCTestExpectation(description: "wait for response")
        sut.fetchSpecies(completion: {
            expectation.fulfill()
            XCTAssertTrue(Thread.isMainThread)
        })
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(sut.fetchError, expectedResult)
    }
    
    func test_fetchMoreSpecies_returns_species() {
        let expectedResult: SpeciesList = SpeciesList(count: 1, nextLimit: 1, nextOffset: 2, results: [])
        let (sut, listUseCase, _) = makeSUT()
        listUseCase.response = .success(expectedResult)
        
        let expectation: XCTestExpectation = XCTestExpectation(description: "wait for response")
        sut.fetchMoreSpecies(completion: { _ in
            expectation.fulfill()
            XCTAssertTrue(Thread.isMainThread)
        })
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(sut.species, expectedResult.results)
        XCTAssertEqual(sut.limit, expectedResult.nextLimit)
        XCTAssertEqual(sut.offset, expectedResult.nextOffset)
    }
    
    func test_fetchMoreSpecies_set_fetchError_on_error() {
        let expectedResult: String = anyNSError().localizedDescription
        let (sut, listUseCase, _) = makeSUT()
        listUseCase.response = .failure(anyNSError())
        
        let expectation: XCTestExpectation = XCTestExpectation(description: "wait for response")
        sut.fetchMoreSpecies(completion: { _ in
            expectation.fulfill()
            XCTAssertTrue(Thread.isMainThread)
        })
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(sut.fetchError, expectedResult)
    }

}

// MARK: - Helpers
extension HomeViewModelTests {
    
    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (HomeViewModelProtocol, PokemonListUseCaseMock, PokemonFavoriteUseCaseMock) {
        let listUseCase = PokemonListUseCaseMock()
        let favoriteUseCase = PokemonFavoriteUseCaseMock()
        let vm = HomeViewModel(pokemonUseCase: listUseCase, favoriteUseCase: favoriteUseCase)
        
        trackForMemoryLeaks(vm)
        
        return (vm, listUseCase, favoriteUseCase)
    }
    
    private class PokemonListUseCaseMock: PokemonListUseCaseProtocol {
        var response: Result<SpeciesList, Error>?

        func fetchSpecies(limit: Int, offset: Int) async -> Result<SpeciesList, Error> {
            response!
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
