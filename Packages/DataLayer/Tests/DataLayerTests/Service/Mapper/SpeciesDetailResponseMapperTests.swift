//
//  SpeciesDetailResponseMapperTests.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 21/05/23.
//

@testable import DataLayer
import XCTest

final class SpeciesDetailResponseMapperTests: XCTestCase {

    func test_map_throwsOnInvalidData() {
        let data: Data = anyData()
        
        XCTAssertThrowsError(
            try SpeciesDetailResponseMapper.map(data)
        )
    }
    
    func test_map_returnsSpeciesDetailOnValidData() {
        let stubbedData = SpeciesDetailStub.asData()
        let speciesDetail = try? SpeciesDetailResponseMapper.map(stubbedData)
        XCTAssertEqual(speciesDetail, SpeciesDetailStub.asObject())
    }

}
