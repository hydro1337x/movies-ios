//
//  HTTPClient.swift
//
//
//  Created by Benjamin Macanovic on 06.06.2024..
//

import Foundation

public struct InvalidHTTPResponseError: Error {
    public init() {}
}

public protocol HTTPClient: Sendable {
    func perform(request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
