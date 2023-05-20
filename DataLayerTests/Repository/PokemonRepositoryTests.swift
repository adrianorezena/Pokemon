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
        let sut: PokemonRepository = makeSUT(response: .success(SpeciesListStub.asObject()))
        let response = await sut.getSpeciesList(limit: 10, offset: 0)
        
        switch response {
        case .success(let speciesList):
            XCTAssertEqual(speciesList, SpeciesListStub.asObject())
            
        case .failure(let failure):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_getSpeciesList_failsOnServiceError() async {
        let sut: PokemonRepository = makeSUT(response: .failure(anyNSError()))
        let response = await sut.getSpeciesList(limit: 10, offset: 0)
        
        switch response {
        case .success(let speciesList):
            XCTFail("Expected failure, got \(speciesList) instead")
            
        case .failure(let failure):
            XCTAssertEqual(failure.localizedDescription, anyNSError().localizedDescription)
        }
    }
    
    // MARK: - Helper
    private func makeSUT(response: Result<SpeciesListResponse, Error>, file: StaticString = #filePath, line: UInt = #line) -> PokemonRepository {
        let service: PokemonServiceStub = PokemonServiceStub(response: response)
        let sut: PokemonRepository = PokemonRepository(pokemonService: service)
        
        trackForMemoryLeaks(service, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
        
    private class PokemonServiceStub: PokemonServiceProtocol {
        let response: Result<SpeciesListResponse, Error>
        
        init(response: Result<SpeciesListResponse, Error>) {
            self.response = response
        }
        
        func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesListResponse, Error> {
            response
        }
    }
    
}
