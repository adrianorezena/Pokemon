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
        let repository = PokemonRepositoryMock(getSpeciesListResponse: .success(expectedSpeciesList))

        let sut = PokemonListUseCase(pokemonRepository: repository)
        let response = await sut.fetchSpecies(limit: 5, offset: 5)
        
        switch response {
        case .success(let speciesList):
            XCTAssertEqual(speciesList, expectedSpeciesList)
            
        case .failure(let failure):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_fetchSpecies_failsOnAnyRepositoryError() async {
        let repository = PokemonRepositoryMock(getSpeciesListResponse: .failure(anyNSError()))
        let sut = PokemonListUseCase(pokemonRepository: repository)
        let response = await sut.fetchSpecies(limit: 5, offset: 5)
        
        switch response {
        case .success(let speciesList):
            XCTFail("Expected failure, got \(speciesList) instead")
            
        case .failure(let failure as NSError):
            XCTAssertEqual(failure, anyNSError())
        }
    }

}

// MARK: - Helpers
extension PokemonListUseCaseTests {
    
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
