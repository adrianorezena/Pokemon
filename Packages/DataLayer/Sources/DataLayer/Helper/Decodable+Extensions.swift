//
//  Decodable+Extensions.swift
//  
//
//  Created by Adriano Rezena on 22/06/23.
//

import Foundation

struct DecodableInvalidData: Error {}

extension Decodable {
    
    static func map(_ data: Data) throws -> Self {
        let decoder: JSONDecoder = JSONDecoder()

        guard let decoded = try? decoder.decode(Self.self, from: data) else {
            throw DecodableInvalidData()
        }
        
        return decoded
    }
}
