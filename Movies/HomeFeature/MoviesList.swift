//
//  MoviesList.swift
//  Movies
//
//  Created by Benjamin Macanovic on 08.06.2024..
//

import SwiftUI

struct MoviesList: View {
    let store: MovieListStore
    
    var body: some View {
        List {
            Group {
                ForEach(store.movies, id: \.self) { movie in
                    Text(movie.title)
                        .onAppear {
                            store.handleMovieAppeared(movie)
                        }
                }
                
                ZStack {
                    if store.isLoading {
                        ProgressView()
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .refreshable { await store.handleOnRefresh() }
        .onAppear(perform: store.handleOnAppear)
        .onDisappear(perform: store.handleOnDisappear)
    }
}

#Preview("Loading") {
    MoviesList(store: PreviewMovieListStore(movies: [], isLoading: true))
}

#Preview("Successful") {
    MoviesList(store: PreviewMovieListStore(
        movies: [
            .init(id: UUID().uuidString, title: "Movie 1"),
            .init(id: UUID().uuidString, title: "Movie 2"),
            .init(id: UUID().uuidString, title: "Movie 3"),
            .init(id: UUID().uuidString, title: "Movie 4"),
            .init(id: UUID().uuidString, title: "Movie 5")
        ],
        isLoading: false)
    )
}
