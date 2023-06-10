//
//  URLSessionHTTPClient.swift
//  
//
//  Created by Adriano Rezena on 06/06/23.
//

import Foundation

extension URLSessionDataTask: HTTPClientTask {}

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    var showDebugLog: Bool = false
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func execute(url: URL, completion: @escaping (HTTPClient.HTTPClientResult) -> Void) -> HTTPClientTask {
        let task: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
            self.logResponse(data: data, response: response, error: error)
            
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
    
    private func logResponse(data: Data?, response: URLResponse?, error: Error?) {
        log("⬇️ ========== RESPONSE ==========")
        
        if let data: Data = data {
            log("⬇️ data: \(String(describing: String(data: data, encoding: .utf8)))")
        }
        
        if let response: HTTPURLResponse = response as? HTTPURLResponse {
            log("⬇️ response code: \(response.statusCode)")
        }
        
        if let error: Error = error {
            log("⬇️ error: \(error)")
        }
        
    }
    
    private func log(_ text: String) {
        guard showDebugLog else { return }
        
        debugPrint(text)
    }
}
