//
//  FetchMoviesService.swift
//  Movies
//
//  Created by Benjamin Macanovic on 08.06.2024..
//

import Foundation

protocol FetchMoviesService: Sendable {
    func fetchMovies(isInitialFetch: Bool) async throws -> [Movie]
}
