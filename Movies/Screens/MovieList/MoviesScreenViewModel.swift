//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation
import Combine

class MoviesScreenViewModel: MoviesScreenViewModelProtocol  {
    
    @Published var movies: [MovieVM] = []
    
    let manager: MovieDatabaseManager
    private var cancellables = Set<AnyCancellable>()
    
    init(manager: MovieDatabaseManager) {
        self.manager = manager
        subscribe()
    }
    
    private func subscribe() {
        manager.movies
            .sink { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)
    }
    
    // MARK: MoviesScreenViewModelProtocol
    
    func fetchMovies() {
        manager.fetchMovies()
    }
}
