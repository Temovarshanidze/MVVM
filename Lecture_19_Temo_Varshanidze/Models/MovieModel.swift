import Foundation

struct MovieResponse: Codable {
    let results: [MovieModel]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
}

struct  MovieModel:Codable {
    let id: Int
    let title: String
    let genreIDs: [Int]
    let voteAverage: Double
    let posterPath: String?
    let releaseDate: String


    enum CodingKeys: String, CodingKey {
        case id, title
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
