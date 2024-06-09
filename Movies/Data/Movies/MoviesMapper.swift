//
//  MoviesMapper.swift
//  Movies
//
//  Created by Benjamin Macanovic on 07.06.2024..
//

import Foundation

enum MoviesMapper {
    static func map(moviesDTO: MoviesDTO) -> [Movie] {
        moviesDTO.results.map(map(movieDTO:))
    }
    
    static func map(movieDTO: MovieDTO) -> Movie {
        .init(id: movieDTO.id.description, title: movieDTO.title, overview: movieDTO.overview)
    }
}


