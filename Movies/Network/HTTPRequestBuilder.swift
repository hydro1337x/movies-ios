//
//  RequestBuilder.swift
//  Movies
//
//  Created by Benjamin Macanovic on 08.06.2024..
//

import Foundation

struct HTTPRequestBuilder {
    private var request: URLRequest?
    
    init(baseURL: String) throws {
        let url = URL(string: baseURL)
        
        guard let url else { throw URLError(.badURL) }
        
        self.request = URLRequest(url: url)
    }
    
    func add(path: String) -> Self {
        map { $0.request?.url?.append(path: path) }
    }
    
    func method(_ method: HTTPMethod) -> Self {
        map { $0.request?.httpMethod = method.rawValue }
    }
    
    func add(headers: [String: String]) -> Self {
        map {
            let allHTTPHeaderFields = $0.request?.allHTTPHeaderFields ?? [:]
            $0.request?.allHTTPHeaderFields = headers.merging(allHTTPHeaderFields, uniquingKeysWith: { $1 })
        }
    }
    
    func add(value: String, forHeader field: String) -> Self {
        map { $0.request?.addValue(value, forHTTPHeaderField: field) }
    }
    
    func add(queryItems: [String:String?]) -> Self {
        map {
            if let url = request?.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                let queries = queryItems.map { URLQueryItem(name: $0, value: $1) }
                components.queryItems = (components.queryItems ?? []) + queries
                $0.request?.url = components.url
            }
        }
    }
    
    func add(value: String?, forQuery field: String) -> Self {
        add(queryItems: [field: value])
    }
    
    func build() throws -> URLRequest {
        guard let request else { throw URLError(.badURL) }
        
        return request
    }
}

private extension HTTPRequestBuilder {
    func map(_ transform: (inout Self) -> Void) -> Self {
        var request = self
        transform(&request)
        return request
    }
}
