//
//  MovieDTO.swift
//  Movies
//
//  Created by Benjamin Macanovic on 08.06.2024..
//

import Foundation

struct MovieDTO: Codable {
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
