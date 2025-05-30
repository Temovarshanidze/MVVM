

import Foundation

struct MovieDetailModel: Codable {
    let id: Int
    let title: String
    let overview: String
    let duration: Int?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case duration = "runtime"
        case posterPath = "poster_path"
    }
}
