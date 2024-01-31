//
//  ContentView.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import SwiftUI

protocol MoviesScreenViewModelProtocol: ObservableObject {
    var movies: [MovieVM] { get }
    var manager: MovieDatabaseManager { get }
    
    func fetchMovies()
}

struct MoviesScreen<ViewModel: MoviesScreenViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                NavigationLink(destination: destinationView(using: movie)) {
                    MovieListItem(movie: movie)
                        .padding(.trailing, 8)
                }
                .padding(.trailing, 16)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Movies")
            .refreshable {
                viewModel.fetchMovies()
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            viewModel.fetchMovies()
        }
    }

    func destinationView(using movie: MovieVM) -> some View {
        MovieDetailsScreen(viewModel: MovieDetailsScreenViewModel(movie: movie, manager: viewModel.manager))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoviesScreen(viewModel: MockViewModel())
                .preferredColorScheme(.light)
            MoviesScreen(viewModel: MockViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
