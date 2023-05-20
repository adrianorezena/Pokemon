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
        let sut = APIRoute.getSpecies(anyURL())
        XCTAssertEqual(sut.url?.absoluteString, anyURL().absoluteString)
    }
    
    func test_getEvolutionChain_returnsRightURL() {
        let sut = APIRoute.getEvolutionChain(anyURL())
        XCTAssertEqual(sut.url?.absoluteString, anyURL().absoluteString)
    }

}
