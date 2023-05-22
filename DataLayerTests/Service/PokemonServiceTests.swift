//
//  PokemonServiceTests.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 21/05/23.
//

@testable import Infrastructure
@testable import DataLayer
import XCTest

final class PokemonServiceTests: XCTestCase {

    struct ClientStub: HTTPClient {
        let response: Result<(Data, HTTPURLResponse), Error>
        
        init(response: Result<(Data, HTTPURLResponse), Error>) {
            self.response = response
        }
        
        func execute(url: URL, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) -> Infrastructure.HTTPClientTask {
            completion(response)
            
            return URLSessionDataTask()
        }
    }
    
    func test_getSpecies_succeedOnServiceResponse() async {
        let client = ClientStub(
            response: .success(
                (SpeciesDetailStub.asData(), HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!)
            )
        )
        
        let sut = PokemonService(client: client)
        let response = await sut.getSpecies(id: "1")
        
        switch response {
        case .success(let speciesDetail):
            XCTAssertEqual(speciesDetail.color.name, "green")
            
        case .failure(let failure):
            XCTFail("Expected success, got \(failure) instead")
        }
    }
    
    func test_getSpecies_failsOnServiceError() async {
        let client = ClientStub(response: .failure(anyNSError()))
        let sut = PokemonService(client: client)
        let response = await sut.getSpecies(id: "1")
        
        switch response {
        case .success(let speciesDetail):
            XCTFail("Expected failure, got \(speciesDetail) instead")
            
        case .failure(let failure):
            XCTAssertEqual(failure.localizedDescription, anyNSError().localizedDescription)
        }
    }
    
    func test_getSpecies_failsOn_mapSpeciesDetailResponse() async {
        let client = ClientStub(
            response: .success((anyData(), HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!))
        )
        
        let sut = PokemonService(client: client)
        let response = await sut.getSpecies(id: "1")
        
        switch response {
        case .success(let speciesDetail):
            XCTFail("Expected failure, got \(speciesDetail) instead")
            
        case .failure(let failure):
            XCTAssertEqual(failure.localizedDescription, SpeciesDetailResponseMapper.Error.invalidData.localizedDescription)
        }
    }
    
}
