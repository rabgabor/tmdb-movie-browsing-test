import Foundation

protocol Request {
    associatedtype Response: Decodable

    var api_key: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var httpMethod: HTTPMethod { get }
}

extension Request {
    var url: URL {
        var component = URLComponents()
        component.scheme = "https"
        component.host = baseUrl
        component.path = path
        component.queryItems = queryItems
        return component.url!
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
