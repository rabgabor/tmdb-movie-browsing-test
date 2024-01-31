//
//  MovieDetailsScreenViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

class MovieDetailsScreenViewModel: MovieDetailsScreenViewModelProtocol {
    
    @Published var movie: MovieVM
    private let manager: MovieDatabaseManager

    init(movie: MovieVM, manager: MovieDatabaseManager) {
        self.movie = movie
        self.manager = manager
    }
    
    // MARK: MovieDetailsScreenViewModelProtocol
    
    func markMovie() {
        manager.markMovie(movie: movie)
    }
}
