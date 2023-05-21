//
//  SpeciesListResponseMapperTests.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 21/05/23.
//

@testable import DataLayer
import XCTest

final class EvolutionResponseMapperTests: XCTestCase {

    func test_map_throwsOnInvalidData() {
        let data: Data = anyData()
        
        XCTAssertThrowsError(
            try EvolutionResponseMapper.map(data)
        )
    }
    
    func test_map_returnsSpeciesListOnValidData() {
        let stubbedData = EvolutionResponseStub.asData()
        let speciesList = try? EvolutionResponseMapper.map(stubbedData)
        XCTAssertEqual(speciesList, EvolutionResponseStub.asObject())
    }

}
