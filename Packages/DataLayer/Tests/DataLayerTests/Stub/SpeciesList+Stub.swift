//
//  SpeciesList+Stub.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 20/05/23.
//

@testable import DataLayer
import Foundation

struct SpeciesListResponseStub {
    
    static func asData() -> Data {
        let json: String =
        """
        {"count":1010,"next":"https://pokeapi.co/api/v2/pokemon-species?offset=5&limit=5","previous":null,"results":[{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon-species/1/"},{"name":"ivysaur","url":"https://pokeapi.co/api/v2/pokemon-species/2/"},{"name":"venusaur","url":"https://pokeapi.co/api/v2/pokemon-species/3/"},{"name":"charmander","url":"https://pokeapi.co/api/v2/pokemon-species/4/"},{"name":"charmeleon","url":"https://pokeapi.co/api/v2/pokemon-species/5/"}]}
        """
        return json.data(using: .utf8)!
    }
    
    static func asObject() -> SpeciesListResponse {
        SpeciesListResponse(
            count: 1010,
            next: "https://pokeapi.co/api/v2/pokemon-species?offset=5&limit=5",
            previous: nil,
            results: [
                SpeciesResponse(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"),
                SpeciesResponse(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon-species/2/"),
                SpeciesResponse(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon-species/3/"),
                SpeciesResponse(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon-species/4/"),
                SpeciesResponse(name: "charmeleon", url: "https://pokeapi.co/api/v2/pokemon-species/5/")
            ]
        )
    }
    
}
