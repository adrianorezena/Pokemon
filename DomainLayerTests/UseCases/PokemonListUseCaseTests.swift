//
//  ListPokemonUseCaseTests.swift
//  DomainLayerTests
//
//  Created by Adriano Rezena on 21/05/23.
//

import DataLayer
@testable import DomainLayer
import XCTest

final class PokemonListUseCaseTests: XCTestCase {

    func test_fetchSpecies_succeedOnRepositoryResponse() async {
        let expectedResult = SpeciesList(count: 1, nextLimit: 5, nextOffset: 5, results: [])
        let sut = makeSUT(repositoryGetSpeciesListResponse: .success(expectedResult))
        await expect(sut, toCompleteWith: .success(expectedResult))
    }
    
    func test_fetchSpecies_failsOnAnyRepositoryError() async {
        let expectedError = anyNSError()
        let sut = makeSUT(repositoryGetSpeciesListResponse: .failure(expectedError))
        await expect(sut, toCompleteWith: .failure(expectedError))
    }

}

// MARK: - Helpers
extension PokemonListUseCaseTests {
    
    private func makeSUT(
        repositoryGetSpeciesListResponse: Result<SpeciesList, Error>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> PokemonListUseCaseProtocol {
        let repository = PokemonRepositoryMock(getSpeciesListResponse: repositoryGetSpeciesListResponse)
        let sut = PokemonListUseCase(pokemonRepository: repository)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func expect(
        _ sut: PokemonListUseCaseProtocol,
        toCompleteWith expectedResult: Result<SpeciesList, Error>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) async {
        let receivedResult = await sut.fetchSpecies(limit: 5, offset: 5)
        
        switch (receivedResult, expectedResult) {
        case (.success, .success):
            break
            
        case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
            XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            
        default:
            XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }
    
    private class PokemonRepositoryMock: PokemonRepositoryProtocol {
        var getSpeciesListResponse: Result<SpeciesList, Error>
        
        init(getSpeciesListResponse: Result<SpeciesList, Error>) {
            self.getSpeciesListResponse = getSpeciesListResponse
        }
        
        func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesList, Error> {
            return getSpeciesListResponse
        }
        
        func fetchEvolution(id: String) async -> Result<[DomainLayer.Species], Error> {
            return .failure(notImplementedError())
        }
        
        func getSpeciesDetail(id: String) async -> Result<DomainLayer.SpeciesDetail, Error> {
            return .failure(notImplementedError())
        }
        
    }
    
}
