import XCTest
@testable import Movies

final class RequestTests: XCTestCase {
    
    var request: FakeRequest?

    override func setUpWithError() throws {
        request = FakeRequest()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequest() throws {
        XCTAssertEqual(request!.url, URL(string: "https://apple.com/apple-vision-pro?price=3500"))
        XCTAssertEqual(request!.urlRequest.httpMethod, HTTPMethod.get.rawValue)
        XCTAssertEqual(request!.urlRequest.url, URL(string: "https://apple.com/apple-vision-pro?price=3500"))
        XCTAssertEqual(request!.urlRequest.allHTTPHeaderFields, ["Content-Type": "application/json"])
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

struct FakeRequest: Request {
    typealias Response = FakeResponse
    
    var api_key: String {
        return "123456"
    }
    
    var baseUrl: String {
        "apple.com"
    }
    
    var path: String {
        "/apple-vision-pro"
    }
    
    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "price", value: "3500")]
    }
    
    var httpMethod: Movies.HTTPMethod {
        .get
    }
}

struct FakeResponse: Decodable {}
