

class MovieListViewModel {
    private let storage = SaveData()
    private let movieManager = MovieManagers()
    
    var movies: [MovieModel] = []
    var favoriteMovies: [MovieModel] =  []
    
    var onMoviesFavoritUpdated :(() -> Void)?
    var onMoviesUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    
    private var currentPage = 1
    private var totalPages = 1
    private var isFetching = false
    
    func fetchMovies(loadMore: Bool = false) {
        guard !isFetching else { return }
        isFetching = true
        
        if !loadMore && movies.isEmpty {
            self.movies = storage.loadMoviesFromLocalStorage()
            print("📦 Loaded saved movies: \(self.movies.count)")
            self.onMoviesUpdated?()
        }
        
        GenreManager.shared.fetchGenres { }
        
        movieManager.getMovies(shouldLoadMore: loadMore) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let newMovie):
                if loadMore {
                    self.movies.append(contentsOf: newMovie)
                } else {
                    self.movies = newMovie
                }
                self.saveCurrentMovies()
                self.onMoviesUpdated?()
                print("🎥 Total movies count: \(self.movies.count)")
                
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
    
    func saveCurrentMovies() {
        storage.saveMoviesToLocalStorage(movies)
    }
    
    func loadSavedMovies() {
        self.movies = storage.loadMoviesFromLocalStorage()
        self.onMoviesUpdated?()
    }
    
    func deleteSavedMovies() {
        storage.clearSavedMovies()
        movies.removeAll()
        onMoviesUpdated?()
    }
    
    var numberOfMovies: Int {
        return movies.count
    }
    
    func movie(at index: Int) -> MovieModel {
        return movies[index]
    }
    
    
    func addFavoriteMovie(movie: MovieModel, completion: @escaping () -> Void) {
        print(favoriteMovies)
        if !favoriteMovies.contains(where: { $0.id == movie.id }) {
            favoriteMovies.append(movie)
            self.onMoviesFavoritUpdated?()
        }else {
            completion()
        }
    }
    
    
    var numberOfFavoriteMovies: Int {
        return favoriteMovies.count
    }
}




