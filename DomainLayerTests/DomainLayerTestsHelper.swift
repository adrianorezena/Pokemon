//
//  DomainLayerTestsHelper.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 22/05/23.
//

import XCTest

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
