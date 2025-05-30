
import Foundation

class MovieDetailViewModel {
    private let movieDetailManager = MovieDetailManager.shared
    var movieDetails: MovieDetailModel?
    
    var onDetailUpdated: (() -> Void)?
    var onErrorReceived: ((String) -> Void)?
    func fetchMovieDetail(movieId: Int) {
        movieDetailManager.fetchMovieDetail(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.movieDetails = movieDetail
                self?.onDetailUpdated?()
            case .failure(let error):
                self?.onErrorReceived?(error.localizedDescription)
            }
        }
    }
    
}
