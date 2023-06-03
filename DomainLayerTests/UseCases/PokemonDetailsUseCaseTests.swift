//
//  PokemonDetailsUseCaseTests.swift
//  DomainLayerTests
//
//  Created by Adriano Rezena on 03/06/23.
//

@testable import DomainLayer
import XCTest

final class PokemonDetailsUseCaseTests: XCTestCase {

    func test_getSpeciesDetail_succeedOnRepositoryResponse() async {
        let expectedResult = SpeciesDetail(chainID: "1", color: "blue")
        let sut = makeSUT(repositoryGetSpeciesDetailsResponse: .success(expectedResult))
        await expect(sut, toCompleteWith: .success(expectedResult))
    }
    
    func test_getSpeciesDetail_failsOnAnyRepositoryError() async {
        let expectedError = anyNSError()
        let sut = makeSUT(repositoryGetSpeciesDetailsResponse: .failure(expectedError))
        await expect(sut, toCompleteWith: .failure(expectedError))
    }

}

// MARK: - Helpers
extension PokemonDetailsUseCaseTests {

    private func makeSUT(
        repositoryGetSpeciesDetailsResponse: Result<SpeciesDetail, Error>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> PokemonDetailsUseCaseProtocol {
        let repository = PokemonRepositoryMock(
            getSpeciesDetailResponse: repositoryGetSpeciesDetailsResponse
        )
        let sut = PokemonDetailsUseCase(pokemonRepository: repository)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(repository, file: file, line: line)
        return sut
    }

    private func expect(
        _ sut: PokemonDetailsUseCaseProtocol,
        toCompleteWith expectedResult: Result<SpeciesDetail, Error>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) async {
        let receivedResult = await sut.getSpeciesDetail(id: "1")
        
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
        
        init(getSpeciesDetailResponse: Result<SpeciesDetail, Error>) {
            self.getSpeciesDetailResponse = getSpeciesDetailResponse
        }
        
        func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesList, Error> {
            return .failure(notImplementedError())
        }
        
        func fetchEvolution(id: String) async -> Result<[Species], Error> {
            return .failure(notImplementedError())
        }
        
        func getSpeciesDetail(id: String) async -> Result<SpeciesDetail, Error> {
            return getSpeciesDetailResponse
        }
        
    }
    
}
