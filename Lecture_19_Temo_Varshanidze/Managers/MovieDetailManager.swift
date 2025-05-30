import Foundation

class MovieDetailManager {
    static let shared = MovieDetailManager()
    private init() {}
    
    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=4d45a7ead527dc8de53cdfce48b2ec2a"
        
        NetworkManager.shared.fetchData(urlString: urlString) { (result: Result<MovieDetailModel, Error>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
}
