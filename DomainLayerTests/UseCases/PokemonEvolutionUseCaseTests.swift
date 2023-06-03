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
        let sut: PokemonEvolutionUseCaseProtocol = makeSUT(
            repositoryGetSpeciesDetailsResponse: .success(SpeciesDetail(chainID: "1", color: "blue")),
            repositoryFetchEvolutionResponse: .success([Species(name: "name", id: "id", imageURL: "")])
        )
        let response = await sut.fetchEvolution(id: "1")
        switch response {
        case .success(let evolution):
            XCTAssertEqual(evolution.count, 1)
            
        case .failure(let failure as NSError):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_fetchSpecies_failsOnGetSpeciesDetailsError() async {
        let sut: PokemonEvolutionUseCaseProtocol = makeSUT(
            repositoryGetSpeciesDetailsResponse: .failure(anyNSError()),
            repositoryFetchEvolutionResponse: .success([])
        )
        let response = await sut.fetchEvolution(id: "1")
        
        switch response {
        case .success(let evolution):
            XCTFail("Expected failure, got \(evolution) instead")
            
        case .failure(let failure as NSError):
            XCTAssertEqual(failure, anyNSError())
        }
    }
    
    func test_fetchSpecies_failsOnFetchEvolutionError() async {
        let sut: PokemonEvolutionUseCaseProtocol = makeSUT(
            repositoryGetSpeciesDetailsResponse: .success(SpeciesDetail(chainID: "1", color: "blue")),
            repositoryFetchEvolutionResponse: .failure(anyNSError())
        )
        let response = await sut.fetchEvolution(id: "1")
        
        switch response {
        case .success(let evolution):
            XCTFail("Expected failure, got \(evolution) instead")
            
        case .failure(let failure as NSError):
            XCTAssertEqual(failure, anyNSError())
        }
    }

}

// MARK: - Helpers
extension PokemonEvolutionUseCaseTests {
    
    func makeSUT(
        repositoryGetSpeciesDetailsResponse: Result<SpeciesDetail, Error>,
        repositoryFetchEvolutionResponse: Result<[Species], Error>
    ) -> PokemonEvolutionUseCaseProtocol {
        let repository = PokemonRepositoryMock(
            getSpeciesDetailResponse: repositoryGetSpeciesDetailsResponse,
            fetchEvolutionResponse: repositoryFetchEvolutionResponse
        )
        let sut = PokemonEvolutionUseCase(pokemonRepository: repository)
        return sut
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
