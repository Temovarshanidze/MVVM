
import Foundation


struct Genre: Codable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}


class GenreManager {
    static let shared = GenreManager()
    private init() {}
    private var genreDictionary: [Int: String] = [:]
    
    func fetchGenres(completion: @escaping () -> Void) {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=4d45a7ead527dc8de53cdfce48b2ec2a"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let genreResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
                self.genreDictionary = Dictionary(uniqueKeysWithValues: genreResponse.genres.map { ($0.id, $0.name) })
                
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("Error decoding genres: \(error)")
            }
        }.resume()
    }
    func getGenreNames(for ids: [Int]) -> String {
        let names = ids.compactMap { genreDictionary[$0] }
        return names.isEmpty ? "Unknown" : names.joined(separator: ", ")
    }
}
