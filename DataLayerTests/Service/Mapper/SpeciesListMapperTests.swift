//
//  SpeciesListMapperTests.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 20/05/23.
//

@testable import DataLayer
import XCTest

final class SpeciesListMapperTests: XCTestCase {

    func test_map_throwsOnInvalidData() {
        let data: Data = anyData()
        
        XCTAssertThrowsError(
            try SpeciesListResponseMapper.map(data)
        )
    }
    
    func test_map_returnsSpeciesListOnValidData() {
        let stubbedData = SpeciesListResponseStub.asData()
        let speciesList = try? SpeciesListResponseMapper.map(stubbedData)
        XCTAssertEqual(speciesList, SpeciesListResponseStub.asObject())
    }

}
