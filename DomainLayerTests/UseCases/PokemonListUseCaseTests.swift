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

    private class PokemonRepositoryStub: PokemonRepositoryProtocol {
        func getSpeciesList(limit: Int, offset: Int) async -> Result<DomainLayer.SpeciesList, Error> {
            return .failure(anyNSError())
        }
        
        func fetchEvolution(id: String) async -> Result<[DomainLayer.Species], Error> {
            return .failure(anyNSError())
        }
        
        func getSpeciesDetail(id: String) async -> Result<DomainLayer.SpeciesDetail, Error> {
            return .failure(anyNSError())
        }
        
    }
    
    func test_fetchSpecies_failsOnAnyRepositoryError() async {
        let sut = PokemonListUseCase(pokemonRepository: PokemonRepositoryStub())
        let response = await sut.fetchSpecies(limit: 5, offset: 5)
        
        switch response {
        case .success(let speciesList):
            XCTFail("Expected failure, got \(speciesList) instead")
            
        case .failure(let failure):
            XCTAssertEqual(failure.localizedDescription, anyNSError().localizedDescription)
        }
    }

}
