import Foundation
import Combine

struct GenresRequest: Request {
    typealias Response = Genres
    
    var api_key: String {
        // TODO: A more elaborate solution here?
        return APIkey
    }
    
    var baseUrl: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        return "/3/genre/movie/list"
    }
    
    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "api_key", value: api_key)]
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
