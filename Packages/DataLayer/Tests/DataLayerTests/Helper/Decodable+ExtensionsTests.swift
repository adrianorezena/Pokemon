//
//  Decodable+ExtensionsTests.swift
//  
//
//  Created by Adriano Rezena on 22/06/23.
//

@testable import DataLayer
import XCTest

final class Decodable_ExtensionsTests: XCTestCase {

    func test_map_throwsOnInvalidData() {
        let data: Data = anyData()
        
        XCTAssertThrowsError(
            try EvolutionResponse.map(data)
        )
    }
    
    func test_map_returnsEvolutionResponse() {
        let stubbedData = EvolutionResponseStub.asData()
        let speciesList = try? EvolutionResponse.map(stubbedData)
        XCTAssertEqual(speciesList, EvolutionResponseStub.asObject())
    }
    
    func test_map_returnsSpeciesDetailResponse() {
        let stubbedData = SpeciesDetailStub.asData()
        let speciesDetail = try? SpeciesDetailResponse.map(stubbedData)
        XCTAssertEqual(speciesDetail, SpeciesDetailStub.asObject())
    }
    
    func test_map_returnsSpeciesListResponse() {
        let stubbedData = SpeciesListResponseStub.asData()
        let speciesDetail = try? SpeciesListResponse.map(stubbedData)
        XCTAssertEqual(speciesDetail, SpeciesListResponseStub.asObject())
    }

}
