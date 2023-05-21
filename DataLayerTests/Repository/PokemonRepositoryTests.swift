//
//  PokemonRepositoryTests.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 20/05/23.
//

@testable import DataLayer
import XCTest

final class PokemonRepositoryTests: XCTestCase {
    
    func test_getSpeciesList_succeedOnServiceResponse() async {
        let sut: PokemonRepository = makeSUT(listResponse: .success(SpeciesListResponseStub.asObject()))
        let response = await sut.getSpeciesList(limit: 10, offset: 0)
        
        switch response {
        case .success(let speciesList):
            XCTAssertEqual(speciesList.count, 1010)
            XCTAssertEqual(speciesList.nextLimit, 5)
            XCTAssertEqual(speciesList.nextOffset, 5)
            XCTAssertEqual(speciesList.results.count, 5)
            
        case .failure(let failure):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_getSpeciesList_failsOnServiceError() async {
        let sut: PokemonRepository = makeSUT(listResponse: .failure(anyNSError()))
        let response = await sut.getSpeciesList(limit: 10, offset: 0)
        
        switch response {
        case .success(let speciesList):
            XCTFail("Expected failure, got \(speciesList) instead")
            
        case .failure(let failure):
            XCTAssertEqual(failure.localizedDescription, anyNSError().localizedDescription)
        }
    }
    
    func test_fetchEvolution_succeedOnServiceResponse() async {
        let sut: PokemonRepository = makeSUT(evolutionResponse: .success(EvolutionResponseStub.asObject()))
        let response = await sut.fetchEvolution(id: "1")
        
        switch response {
        case .success(let evolution):
            XCTAssertEqual(evolution.count, 3)
            
        case .failure(let failure):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_fetchEvolution_failsOnServiceError() async {
        let sut: PokemonRepository = makeSUT(evolutionResponse: .failure(anyNSError()))
        let response = await sut.fetchEvolution(id: "1")
        
        switch response {
        case .success(let speciesList):
            XCTFail("Expected failure, got \(speciesList) instead")
            
        case .failure(let failure):
            XCTAssertEqual(failure.localizedDescription, anyNSError().localizedDescription)
        }
    }
    
    // MARK: - Helper
    private func makeSUT(
        listResponse: Result<SpeciesListResponse, Error>? = nil,
        evolutionResponse: Result<EvolutionResponse, Error>? = nil,
        file: StaticString = #filePath, line: UInt = #line
    ) -> PokemonRepository {
        let service: PokemonServiceStub = PokemonServiceStub(
            listResponse: listResponse,
            evolutionResponse: evolutionResponse
        )
        let sut: PokemonRepository = PokemonRepository(pokemonService: service)
        
        trackForMemoryLeaks(service, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
        
    private class PokemonServiceStub: PokemonServiceProtocol {
        let listResponse: Result<SpeciesListResponse, Error>
        let evolutionResponse: Result<EvolutionResponse, Error>
        
        init(
            listResponse: Result<SpeciesListResponse, Error>? = nil,
            evolutionResponse: Result<EvolutionResponse, Error>? = nil
        ) {
            self.listResponse = listResponse ?? .failure(NSError(domain: "Not espected", code: 0))
            self.evolutionResponse = evolutionResponse ?? .failure(NSError(domain: "Not espected", code: 0))
        }
        
        func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesListResponse, Error> {
            listResponse
        }
        
        func fetchEvolution(id: String) async -> Result<EvolutionResponse, Error> {
            evolutionResponse
        }
    }

}
