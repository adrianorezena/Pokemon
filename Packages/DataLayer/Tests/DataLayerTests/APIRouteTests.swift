//
//  APIRouteTests.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 20/05/23.
//

@testable import DataLayer
import XCTest

final class APIRouteTests: XCTestCase {

    func test_getSpeciesList_returnsRightURL() {
        let sut = APIRoute.getSpeciesList(limit: 20, offset: 0)
        XCTAssertEqual(sut.url?.absoluteString, "https://pokeapi.co/api/v2/pokemon-species?limit=20&offset=0")
    }
    
    func test_getSpecies_returnsRightURL() {
        let sut = APIRoute.getSpecies(id: "1")
        XCTAssertEqual(sut.url?.absoluteString, "https://pokeapi.co/api/v2/pokemon-species/1")
    }
    
    func test_getEvolutionChain_returnsRightURL() {
        let sut = APIRoute.getEvolutionChain(id: "1")
        XCTAssertEqual(sut.url?.absoluteString, "https://pokeapi.co/api/v2/evolution-chain/1")
    }

}
