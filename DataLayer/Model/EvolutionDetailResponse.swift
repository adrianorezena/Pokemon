//
//  EvolutionResponse.swift
//  DataLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

public struct EvolutionDetailResponse: Codable, Equatable {
    public let minLevel: Int
    public let needsOverworldRain: Bool
    public let timeOfDay: String
    public let trigger: SpeciesResponse
    public let turnUpsideDown: Bool
    
    public init(minLevel: Int, needsOverworldRain: Bool, timeOfDay: String, trigger: SpeciesResponse, turnUpsideDown: Bool) {
        self.minLevel = minLevel
        self.needsOverworldRain = needsOverworldRain
        self.timeOfDay = timeOfDay
        self.trigger = trigger
        self.turnUpsideDown = turnUpsideDown
    }

    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case timeOfDay = "time_of_day"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }
}

