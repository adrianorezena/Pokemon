//
//  PokemonEvolutionUseCaseTests.swift
//  DomainLayerTests
//
//  Created by Adriano Rezena on 03/06/23.
//

@testable import DomainLayer
import XCTest

final class PokemonEvolutionUseCaseTests: XCTestCase {

    func test_fetchSpecies_succeedOnGetSpeciesDetailAndFetchEvolutionResponse() async {
        let expectedResult = [Species(name: "name", id: "id", imageURL: "")]
        let sut: PokemonEvolutionUseCaseProtocol = makeSUT(
            repositoryGetSpeciesDetailsResponse: .success(SpeciesDetail(chainID: "1", color: "blue")),
            repositoryFetchEvolutionResponse: .success(expectedResult)
        )
        
        await expect(sut, toCompleteWith: .success(expectedResult))
    }
    
    func test_fetchSpecies_failsOnGetSpeciesDetailsError() async {
        let expectedError = anyNSError()
        let sut: PokemonEvolutionUseCaseProtocol = makeSUT(
            repositoryGetSpeciesDetailsResponse: .failure(expectedError),
            repositoryFetchEvolutionResponse: .success([])
        )
        
        await expect(sut, toCompleteWith: .failure(expectedError))
    }
    
    func test_fetchSpecies_failsOnFetchEvolutionError() async {
        let expectedError = anyNSError()
        let sut: PokemonEvolutionUseCaseProtocol = makeSUT(
            repositoryGetSpeciesDetailsResponse: .success(SpeciesDetail(chainID: "1", color: "blue")),
            repositoryFetchEvolutionResponse: .failure(expectedError)
        )
        
        await expect(sut, toCompleteWith: .failure(expectedError))
    }

}

// MARK: - Helpers
extension PokemonEvolutionUseCaseTests {
    
    private func makeSUT(
        repositoryGetSpeciesDetailsResponse: Result<SpeciesDetail, Error>,
        repositoryFetchEvolutionResponse: Result<[Species], Error>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> PokemonEvolutionUseCaseProtocol {
        let repository = PokemonRepositoryMock(
            getSpeciesDetailResponse: repositoryGetSpeciesDetailsResponse,
            fetchEvolutionResponse: repositoryFetchEvolutionResponse
        )
        let sut = PokemonEvolutionUseCase(pokemonRepository: repository)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func expect(
        _ sut: PokemonEvolutionUseCaseProtocol,
        toCompleteWith expectedResult: Result<[Species], Error>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) async {
        let receivedResult = await sut.fetchEvolution(id: "1")
        
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
        var getSpeciesDetailResponse: Result<SpeciesDetail, Error>
        var fetchEvolutionResponse: Result<[Species], Error>
        
        init(getSpeciesDetailResponse: Result<SpeciesDetail, Error>, fetchEvolutionResponse: Result<[Species], Error>) {
            self.getSpeciesDetailResponse = getSpeciesDetailResponse
            self.fetchEvolutionResponse = fetchEvolutionResponse
        }
        
        func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesList, Error> {
            return .failure(notImplementedError())
        }
        
        func fetchEvolution(id: String) async -> Result<[Species], Error> {
            return fetchEvolutionResponse
        }
        
        func getSpeciesDetail(id: String) async -> Result<SpeciesDetail, Error> {
            return getSpeciesDetailResponse
        }
        
    }
    
}
