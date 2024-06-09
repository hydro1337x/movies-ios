//
//  MoviesApp.swift
//  Movies
//
//  Created by Benjamin Macanovic on 06.06.2024..
//

import SwiftUI

@main
struct MoviesApp: App {
    let upcomingMoviesStore: MovieListStore
    let nowPlayingMoviesStore: MovieListStore
    
    init() {
        let upcomingMoviesService = FetchUpcomingMoviesService(
            client: URLSession.shared,
            paginator: DefaultPaginator(),
            decoder: .init()
        ).withDeduplicator()
        
        let nowPlayingMoviesService = FetchNowPlayingMoviesService(
            client: URLSession.shared,
            paginator: DefaultPaginator(),
            decoder: .init()
        ).withDeduplicator()
        
        self.upcomingMoviesStore = ConcreteMovieListStore(service: upcomingMoviesService)
        self.nowPlayingMoviesStore = ConcreteMovieListStore(service: nowPlayingMoviesService)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(nowPlayingMoviesStore: nowPlayingMoviesStore, upcomingMoviesStore: upcomingMoviesStore)
        }
    }
}
