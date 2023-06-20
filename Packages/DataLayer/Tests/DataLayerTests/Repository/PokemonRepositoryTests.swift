//
//  PokemonRepositoryTests.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 20/05/23.
//

import DomainLayer
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
    
    func test_getSpecies_succeedOnServiceResponse() async {
        let sut: PokemonRepository = makeSUT(detailResponse: .success(SpeciesDetailStub.asObject()))
        let response = await sut.getSpeciesDetail(id: "1")
        
        switch response {
        case .success(let speciesDetail):
            XCTAssertEqual(speciesDetail.chainID, "1")
            XCTAssertEqual(speciesDetail.color, "green")
            
        case .failure(let failure):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_getSpecies_failsOnServiceError() async {
        let sut: PokemonRepository = makeSUT(detailResponse: .failure(anyNSError()))
        let response = await sut.getSpeciesDetail(id: "1")
        
        switch response {
        case .success(let speciesDetail):
            XCTFail("Expected failure, got \(speciesDetail) instead")
            
        case .failure(let failure):
            XCTAssertEqual(failure.localizedDescription, anyNSError().localizedDescription)
        }
    }
}

// MARK: - Helper
extension PokemonRepositoryTests {
    
    private func makeSUT(
        listResponse: Result<SpeciesListResponse, Error>? = nil,
        evolutionResponse: Result<EvolutionResponse, Error>? = nil,
        detailResponse: Result<SpeciesDetailResponse, Error>? = nil,
        file: StaticString = #filePath, line: UInt = #line
    ) -> PokemonRepository {
        let service: PokemonServiceStub = PokemonServiceStub(
            listResponse: listResponse,
            evolutionResponse: evolutionResponse,
            detailResponse: detailResponse
        )
        
        let sut: PokemonRepository = PokemonRepository(pokemonService: service, speciesStore: StoreMock())
        
        trackForMemoryLeaks(service, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
        
    private class PokemonServiceStub: PokemonServiceProtocol {
        let listResponse: Result<SpeciesListResponse, Error>
        let evolutionResponse: Result<EvolutionResponse, Error>
        let detailResponse: Result<SpeciesDetailResponse, Error>
        
        init(
            listResponse: Result<SpeciesListResponse, Error>? = nil,
            evolutionResponse: Result<EvolutionResponse, Error>? = nil,
            detailResponse: Result<SpeciesDetailResponse, Error>? = nil
        ) {
            self.listResponse = listResponse ?? .failure(NSError(domain: "Not espected", code: 0))
            self.evolutionResponse = evolutionResponse ?? .failure(NSError(domain: "Not espected", code: 0))
            self.detailResponse = detailResponse ?? .failure(NSError(domain: "Not espected", code: 0))
        }
        
        func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesListResponse, Error> {
            listResponse
        }
        
        func fetchEvolution(id: String) async -> Result<EvolutionResponse, Error> {
            evolutionResponse
        }
        
        func getSpecies(id: String) async -> Result<SpeciesDetailResponse, Error> {
            detailResponse
        }
    }
    
    private class StoreMock: SpeciesStore {
        func get(id: String) throws -> Species? {
            nil
        }
        
        func getAll() throws -> [DomainLayer.Species] {
            []
        }
        
        func save(_ species: DomainLayer.Species) throws {}
        
        func delete(_ species: DomainLayer.Species) throws {}
    }
    
}
