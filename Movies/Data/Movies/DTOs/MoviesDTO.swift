//
//  MoviesDTO.swift
//  Movies
//
//  Created by Benjamin Macanovic on 08.06.2024..
//

import Foundation

struct MoviesDTO: Codable {
    let dates: DatesDTO
    let page: Int
    let results: [MovieDTO]
    let total_pages: Int
    let total_results: Int
}

extension MoviesDTO: Paginatable {
    var currentPage: Int { page }
    var totalPages: Int { total_pages }
}
