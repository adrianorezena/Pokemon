//
//  DataLayerTestsHelper.swift
//  DataLayerTests
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

func anyURL() -> URL {
    URL(string: "http://url.com")!
}

func anyData() -> Data {
    Data("any data".utf8)
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}
