//
//  PreviewMovieListStore.swift
//  Movies
//
//  Created by Benjamin Macanovic on 10.06.2024..
//

import Foundation

class PreviewMovieListStore: MovieListStore {
    var movies: [MovieViewModel]
    var isLoading: Bool
    
    init(movies: [MovieViewModel], isLoading: Bool) {
        self.movies = movies
        self.isLoading = isLoading
    }
    
    func handleOnAppear() {}
    
    func handleOnRefresh() async {}
    
    func handleMovieAppeared(_ movie: MovieViewModel) {}
    
    func handleOnDisappear() {}
}
