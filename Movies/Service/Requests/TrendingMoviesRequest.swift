import Foundation
import Combine

struct TrendingMoviesRequest: Request {
    typealias Response = TrendingMovies
    
    var api_key: String {
        // TODO: A more elaborate solution here?
        return APIkey
    }
    
    var baseUrl: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        return "/3/trending/movie/week"
    }
    
    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "api_key", value: api_key)]
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
