import Foundation

protocol JsonMovieDelegate: AnyObject {
    func configure(with movies: MovieModel)
}



protocol JsonMovieDetailDelegate: AnyObject {
    func configure(with movies: MovieDetailModel)
}

protocol MovieRemoveDelegate: AnyObject {
    func removeMovie(cell : FavoriteMovieCell)
}

protocol MovieAddDelegate: AnyObject {
    func addMovie(cell : MovieCell)
}

