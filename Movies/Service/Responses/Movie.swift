struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let genreIDs: [Int]
    let voteAverage: Float
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
    }
}
