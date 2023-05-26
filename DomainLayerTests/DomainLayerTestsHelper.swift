//
//  DomainLayerTestsHelper.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 22/05/23.
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func notImplementedError() -> NSError {
    NSError(domain: "Not Implemented", code: 0)
}
