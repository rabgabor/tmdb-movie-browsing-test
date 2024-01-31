import Foundation
import Combine

protocol ServiceProtocol {
    func fetch<T: Request>(request: T) -> AnyPublisher<T.Response, ApiError>
}

class Service: ServiceProtocol {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: ServiceProtocol
    
    func fetch<T: Request>(request: T) -> AnyPublisher<T.Response, ApiError> {
        session.dataTaskPublisher(for: request.urlRequest)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw ApiError.requestFailed
                }
                guard (200..<300) ~= httpResponse.statusCode else {
                    throw ApiError.invalidResponse
                }
                return result.data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: T.Response.self, decoder: JSONDecoder())
            .mapError({ error -> ApiError in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.decodingFailed
            })
            .eraseToAnyPublisher()
    }
}

enum ApiError: Error {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case customError(ErrorModel)
    var errorDescription: String? {
        switch self {
        case .requestFailed:
            return "Server is not reachable"
        case .badURL:
            return "Not a valid URL"
        case .decodingFailed:
            return "Json failed"
        case .invalidResponse:
            return "Response type not a json"
        case .customError(let model):
            return model.message
        }
    }
}

struct ErrorModel: Codable {
    let code: String?
    let message: String?
}
