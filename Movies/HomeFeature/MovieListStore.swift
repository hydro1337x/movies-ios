//
//  MovieListStore.swift
//  Movies
//
//  Created by Benjamin Macanovic on 07.06.2024..
//

import Foundation

@MainActor
protocol MovieListStore: Sendable {
    var movies: [MovieViewModel] { get }
    var isLoading: Bool { get }
    
    func handleOnAppear()
    func handleOnRefresh() async
    func handleMovieAppeared(_ movie: MovieViewModel)
    func handleOnDisappear()
}

@Observable
class ConcreteMovieListStore: MovieListStore {
    private(set) var movies: [MovieViewModel]
    private(set) var isLoading = false
    
    private(set) var task: Task<Void, Never>?
    
    private let service: FetchMoviesService
    
    init(
        movies: [MovieViewModel] = [],
        service: FetchMoviesService
    ) {
        self.movies = movies
        self.service = service
    }
}

// MARK: - View Actions
extension ConcreteMovieListStore {
    func handleOnAppear() {
        fetchAndMutate(isInitialFetch: true)
    }
    
    func handleOnRefresh() async {
        fetchAndMutate(isInitialFetch: true)
    }
    
    func handleMovieAppeared(_ movie: MovieViewModel) {
        guard movie.id == movies.last?.id, !isLoading else { return }
        fetchAndMutate(isInitialFetch: false)
    }
    
    func handleOnDisappear() {
        task?.cancel()
    }
}

// MARK: - Helpers
private extension ConcreteMovieListStore {
    func fetchAndMutate(isInitialFetch: Bool) {
        task?.cancel()
        task = Task { @MainActor in
            isLoading = true
            defer { isLoading = false }
            
            do {
                let movies = try await service.fetchMovies(isInitialFetch: isInitialFetch)
                let mappedMovies = movies.map { MovieViewModel(id: $0.id, title: $0.title) }
                
                if isInitialFetch {
                    self.movies = mappedMovies
                } else {
                    self.movies += mappedMovies
                }
            } catch {
                print(error)
            }
        }
    }
}
