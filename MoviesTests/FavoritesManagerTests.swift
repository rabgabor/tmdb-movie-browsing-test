import XCTest
@testable import Movies

final class FavoritesManagerTests: XCTestCase {

    var favoritesManager: FavoritesManager?
    
    override func setUpWithError() throws {
        let mockUserDefaults = MockUserDefault()
        favoritesManager = FavoritesManager(defaults: mockUserDefaults)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testMarkFavorite() {
        favoritesManager!.markFavorite(movieId: "A")
        XCTAssertTrue(favoritesManager!.isFavorite(movieId: "A"))
        XCTAssertFalse(favoritesManager!.isFavorite(movieId: "B"))
        
        // Removing from the favorites
        favoritesManager!.markFavorite(movieId: "A")
        XCTAssertFalse(favoritesManager!.isFavorite(movieId: "A"))
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockUserDefault: UserDefaults {
    var persistedUserName: String? = nil
    var persistenceKey: String? = nil
        
    override func set(_ value: Any?, forKey defaultName: String) {
        persistedUserName = value as? String
        persistenceKey = defaultName
    }
}
