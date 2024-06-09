//
//  URLSession+HTTPClient.swift
//
//
//  Created by Benjamin Macanovic on 06.06.2024..
//

import Foundation

extension URLSession: HTTPClient {
    public func perform(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { throw InvalidHTTPResponseError() }
            return (data, httpResponse)
        } catch {
            throw error
        }
    }
}
