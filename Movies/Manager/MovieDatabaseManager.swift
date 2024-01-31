import Foundation
import Combine

protocol MovieDatabaseManager {
    var movies: CurrentValueSubject<[MovieVM], Never> { get }
    
    func fetchMovies()
    func markMovie(movie: MovieVM)
}

class TMDBManager: MovieDatabaseManager {
    var movies =  CurrentValueSubject<[MovieVM], Never>([])
    private let service: ServiceProtocol
    private let favorites: FavoritesManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: ServiceProtocol = Service(), favorites: FavoritesManagerProtocol = FavoritesManager()) {
        self.service = service
        self.favorites = favorites
    }
    
    // MARK: MovieDatabaseManager
    
    func fetchMovies() {
        service.fetch(request: TrendingMoviesRequest()).zip(service.fetch(request: GenresRequest()), { [unowned self] trendingMovies, genres -> [MovieVM] in
            trendingMovies.movies.map { movie -> MovieVM in
                return self.buildMovieViewModel(genres: genres, movie: movie)
            }})
        .receive(on: DispatchQueue.main)
        .sink { status in
            switch status {
            case .finished:
                break
            case .failure(let error):
                print("Failed fetching movies: \(error.localizedDescription)")
                break
            }
        } receiveValue: { [weak self] movies in
            self?.movies.send(movies)
        }
        .store(in: &cancellables)
    }
    
    func buildMovieViewModel(genres: Genres, movie: Movie) -> MovieVM {
        let genreString = genres.genres.filter({ movie.genreIDs.contains($0.id) }).map({ $0.name }).formatted()
        let image = MovieVM.Image(small: "https://image.tmdb.org/t/p/w185\(movie.posterPath)",
                                  large: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        let isMarked = favorites.isFavorite(movieId: String(movie.id))
        
        let movieVM = MovieVM(id: movie.id.description,
                              title: movie.title,
                              genres: genreString,
                              overView: movie.overview,
                              image: image,
                              popularity: movie.voteAverage,
                              isMarked: isMarked)
        
        return movieVM
    }
    
    func markMovie(movie: MovieVM) {
        favorites.markFavorite(movieId: movie.id)
        
        if let index = movies.value.firstIndex(where: { $0.id == movie.id }) {
            movies.value[index].isMarked = favorites.isFavorite(movieId: movie.id)
        }
    }
}
