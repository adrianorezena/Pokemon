//
//  EvolutionResponse+Stub.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 21/05/23.
//

@testable import DataLayer
import Foundation

struct EvolutionResponseStub {
    
    static func asData() -> Data {
        let json: String =
        """
        {"baby_trigger_item":null,"chain":{"evolution_details":[],"evolves_to":[{"evolution_details":[{"gender":null,"held_item":null,"item":null,"known_move":null,"known_move_type":null,"location":null,"min_affection":null,"min_beauty":null,"min_happiness":null,"min_level":16,"needs_overworld_rain":false,"party_species":null,"party_type":null,"relative_physical_stats":null,"time_of_day":"","trade_species":null,"trigger":{"name":"level-up","url":"https://pokeapi.co/api/v2/evolution-trigger/1/"},"turn_upside_down":false}],"evolves_to":[{"evolution_details":[{"gender":null,"held_item":null,"item":null,"known_move":null,"known_move_type":null,"location":null,"min_affection":null,"min_beauty":null,"min_happiness":null,"min_level":32,"needs_overworld_rain":false,"party_species":null,"party_type":null,"relative_physical_stats":null,"time_of_day":"","trade_species":null,"trigger":{"name":"level-up","url":"https://pokeapi.co/api/v2/evolution-trigger/1/"},"turn_upside_down":false}],"evolves_to":[],"is_baby":false,"species":{"name":"venusaur","url":"https://pokeapi.co/api/v2/pokemon-species/3/"}}],"is_baby":false,"species":{"name":"ivysaur","url":"https://pokeapi.co/api/v2/pokemon-species/2/"}}],"is_baby":false,"species":{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon-species/1/"}},"id":1}
        """
        return json.data(using: .utf8)!
    }
    
    static func asObject() -> EvolutionResponse {
        EvolutionResponse(
            chain: ChainResponse(
                evolvesTo: [
                    ChainResponse(
                        evolvesTo: [
                            ChainResponse(
                                evolvesTo: [],
                                species: SpeciesResponse(
                                    name: "venusaur",
                                    url: "https://pokeapi.co/api/v2/pokemon-species/3/"
                                )
                            )
                        ],
                        species: SpeciesResponse(
                            name: "ivysaur",
                            url: "https://pokeapi.co/api/v2/pokemon-species/2/"
                        )
                    )
                ],
                species: SpeciesResponse(
                    name: "bulbasaur",
                    url: "https://pokeapi.co/api/v2/pokemon-species/1/"
                )
            ),
            id: 1
        )
    }
}
