//
//  SpeciesDetail+Stub.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 21/05/23.
//

@testable import DataLayer
import Foundation

struct SpeciesDetailStub {
 
    static func asData() -> Data {
        let json: String =
        """
        {"color":{"name":"green","url":"https://pokeapi.co/api/v2/pokemon-color/5/"},"evolution_chain":{"url":"https://pokeapi.co/api/v2/evolution-chain/1/"},"evolves_from_species":null}
        """
        return json.data(using: .utf8)!
    }
    
    static func asObject() -> SpeciesDetailResponse {
        SpeciesDetailResponse(
            color: ColorResponse(
                name: "green",
                url: "https://pokeapi.co/api/v2/pokemon-color/5/"
            ),
            evolutionChain: EvolutionChainResponse(
                url: "https://pokeapi.co/api/v2/evolution-chain/1/"
            )
        )
    }
    
}
