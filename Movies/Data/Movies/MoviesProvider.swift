//
//  MoviesProvider.swift
//  Movies
//
//  Created by Benjamin Macanovic on 07.06.2024..
//

import Foundation

enum MoviesProvider {
    static func makeNowPlayingRequest(page: Int) throws -> URLRequest {
        try HTTPRequestBuilder(baseURL: Configuration.apiBaseURL)
            .add(path: "movie/now_playing")
            .method(.get)
            .add(value: "application/json", forHeader: "accept")
            .add(queryItems: [
                "api_key": Configuration.apiKey,
                "page" : page.description
            ])
            .build()
    }
    
    static func makeUpcomingRequest(page: Int) throws -> URLRequest {
        let req = try HTTPRequestBuilder(baseURL: Configuration.apiBaseURL)
            .add(path: "movie/upcoming")
            .method(.get)
            .add(value: "application/json", forHeader: "accept")
            .add(queryItems: [
                "api_key": Configuration.apiKey,
                "page" : page.description
            ])
            .build()
        
        return req
    }
}
