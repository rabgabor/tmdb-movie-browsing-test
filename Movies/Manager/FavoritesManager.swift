import Foundation

protocol FavoritesManagerProtocol {
    func markFavorite(movieId: String)
    func isFavorite(movieId: String) -> Bool
}

class FavoritesManager: FavoritesManagerProtocol {
    private let defaults: UserDefaults
    private let favoritesKey = "Favorites"
    
    private var favoritesIdSet: Set<String> {
        didSet {
            let favoritesIdArray = Array(favoritesIdSet)
            defaults.set(favoritesIdArray, forKey: favoritesKey)
            defaults.synchronize() // Overkill, but ensures that the data is saved before an early termination.
        }
    }
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        let favoritesIdArray = defaults.object(forKey: favoritesKey) as? [String] ?? []
        favoritesIdSet = Set(favoritesIdArray)
    }
    
    func markFavorite(movieId: String) {
        if favoritesIdSet.contains(movieId) {
            favoritesIdSet.remove(movieId)
        } else {
            favoritesIdSet.insert(movieId)
        }
    }
    
    func isFavorite(movieId: String) -> Bool {
        return favoritesIdSet.contains(movieId)
    }
}
