import XCTest
@testable import Movies
import Combine

final class MovieDatabaseManagerTests: XCTestCase {
    
    var manager: TMDBManager?
    @Published var movies: [MovieVM] = []
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        manager = TMDBManager()
        movies = []
        
        manager!.movies
            .sink { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBuildMovieViewModel() {

        let movie = Movie(id: 666, title: "Pulp Fiction", overview: "Good stuff", posterPath: "poster.jpg", genreIDs: [1, 2, 3], voteAverage: 45.0)
        
        let genres = [
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Comedy"),
            Genre(id: 3, name: "Romance")
        ]
        
        let movieVM = manager!.buildMovieViewModel(genres: Genres(genres: genres), movie: movie)
        
        XCTAssertEqual(movieVM.title, movie.title)
        XCTAssertEqual(movieVM.overView, movie.overview)
        XCTAssertEqual(movieVM.popularity, movie.voteAverage)
        XCTAssertEqual(movieVM.image.large, "https://image.tmdb.org/t/p/w500poster.jpg")
        XCTAssertEqual(movieVM.image.small, "https://image.tmdb.org/t/p/w185poster.jpg")
        XCTAssertEqual(movieVM.genres, "Action, Comedy, and Romance")
    }
    
    func testSubscription() {
        XCTAssertEqual(movies.count, 0)
        
        manager!.movies.send(previewMovies)
        
        XCTAssertEqual(movies.count, 3)
        
        manager!.markMovie(movie: previewMovies.first!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
