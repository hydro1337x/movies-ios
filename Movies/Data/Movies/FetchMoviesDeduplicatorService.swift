//
//  FetchMoviesDeduplicatorService.swift
//  Movies
//
//  Created by Benjamin Macanovic on 09.06.2024..
//

import Foundation

/**
 The MovieDB paged API sometimes returns duplicates of the same item, this service removes those duplicates.
 */
actor FetchMoviesDeduplicatorService: FetchMoviesService {
    private let decoratee: FetchMoviesService
    private var movieIds: Set<String> = []
    
    init(_ decoratee: FetchMoviesService) {
        self.decoratee = decoratee
    }
    
    func fetchMovies(isInitialFetch: Bool) async throws -> [Movie] {
        if isInitialFetch {
            movieIds.removeAll()
        }
        
        let movies = try await decoratee.fetchMovies(isInitialFetch: isInitialFetch)
        
        let deduplicatedMovies = movies
            .filter { movie in
                !movieIds.contains(movie.id)
            }
        
        let deduplicatedMovieIds = deduplicatedMovies.map(\.id)
        
        movieIds.formUnion(deduplicatedMovieIds)
        
        return deduplicatedMovies
    }
}

extension FetchMoviesService {
    func withDeduplicator() -> FetchMoviesService {
        FetchMoviesDeduplicatorService(self)
    }
}
