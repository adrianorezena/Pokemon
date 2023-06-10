//
//  HTTPClient.swift
//  
//
//  Created by Adriano Rezena on 06/06/23.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias HTTPClientResult = Swift.Result<(Data, HTTPURLResponse), Error>
    
    @discardableResult
    func execute(url: URL, completion: @escaping (HTTPClient.HTTPClientResult) -> Void) -> HTTPClientTask
}
