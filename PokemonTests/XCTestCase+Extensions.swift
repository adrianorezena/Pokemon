//
//  XCTestCase+Extensions.swift
//  PokemonTests
//
//  Created by Adriano Rezena on 22/06/23.
//

import XCTest

func anyURLString() -> String {
    "http://url.com"
}

func anyURL() -> URL {
    URL(string: anyURLString())!
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func notImplementedError() -> NSError {
    NSError(domain: "Not Implemented", code: 0)
}

extension XCTestCase {
    
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }

}
