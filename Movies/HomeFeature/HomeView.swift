//
//  HomeView.swift
//  Movies
//
//  Created by Benjamin Macanovic on 09.06.2024..
//

import SwiftUI

struct HomeView: View {
    let nowPlayingMoviesStore: MovieListStore
    let upcomingMoviesStore: MovieListStore
    
    var body: some View {
        TabView {
            MoviesList(store: upcomingMoviesStore)
            MoviesList(store: nowPlayingMoviesStore)
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    HomeView(
        nowPlayingMoviesStore: PreviewMovieListStore(movies: [], isLoading: true),
        upcomingMoviesStore: PreviewMovieListStore(movies: [], isLoading: true)
    )
}
