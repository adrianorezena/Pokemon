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
        let expectedSpeciesList = SpeciesList(count: 1, nextLimit: 5, nextOffset: 5, results: [])
        let sut = PokemonListUseCase(pokemonRepository: PokemonRepositoryStub(getSpeciesListResponse: .success(expectedSpeciesList)))
        let response = await sut.fetchSpecies(limit: 5, offset: 5)
        
        switch response {
        case .success(let speciesList):
            XCTAssertEqual(speciesList, expectedSpeciesList)
            
        case .failure(let failure):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_fetchSpecies_failsOnAnyRepositoryError() async {
        let sut = PokemonListUseCase(pokemonRepository: PokemonRepositoryStub(getSpeciesListResponse: .failure(anyNSError())))
        let response = await sut.fetchSpecies(limit: 5, offset: 5)
        
        switch response {
        case .success(let speciesList):
            XCTFail("Expected failure, got \(speciesList) instead")
            
        case .failure(let failure as NSError):
            XCTAssertEqual(failure, anyNSError())
        }
    }
    
    // MARK: - Helper
    private class PokemonRepositoryStub: PokemonRepositoryProtocol {
        var getSpeciesListResponse: Result<SpeciesList, Error>
        
        init(getSpeciesListResponse: Result<SpeciesList, Error> = .failure(notImplementedError())) {
            self.getSpeciesListResponse = getSpeciesListResponse
        }
        
        func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesList, Error> {
            return getSpeciesListResponse
        }
        
        func fetchEvolution(id: String) async -> Result<[DomainLayer.Species], Error> {
            return .failure(anyNSError())
        }
        
        func getSpeciesDetail(id: String) async -> Result<DomainLayer.SpeciesDetail, Error> {
            return .failure(anyNSError())
        }
        
    }
    
}
