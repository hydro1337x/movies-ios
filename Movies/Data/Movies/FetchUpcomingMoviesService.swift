//
//  FetchUpcomingMoviesService.swift
//  Movies
//
//  Created by Benjamin Macanovic on 08.06.2024..
//

import Foundation

struct FetchUpcomingMoviesService: FetchMoviesService {
    private let client: HTTPClient
    private let paginator: Paginator
    private let decoder: JSONDecoder
    
    init(
        client: HTTPClient,
        paginator: Paginator,
        decoder: JSONDecoder
    ) {
        self.client = client
        self.paginator = paginator
        self.decoder = decoder
    }
    
    func fetchMovies(isInitialFetch: Bool) async throws -> [Movie] {
        if isInitialFetch {
            await paginator.reset()
        }
        
        let page = await paginator.getCurrentPage()
        
        let request = try MoviesProvider.makeUpcomingRequest(page: page)
        
        let (data, _) = try await client.perform(request: request)
        
        let dto = try decoder.decode(MoviesDTO.self, from: data)
        
        try await paginator.paginate(dto)
        
        let movies = MoviesMapper.map(moviesDTO: dto)

        return movies
    }
}


