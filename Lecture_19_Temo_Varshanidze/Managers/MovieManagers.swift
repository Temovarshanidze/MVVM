import Foundation

class MovieManagers {
    
    static let shared = MovieManagers()
    
     init() {}
    
    private var  currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    func resetPagination() {
        currentPage = 1
        totalPages = 1
    }
    
    func getMovies(shouldLoadMore: Bool = false,  completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        guard !isLoading else { return }
        
        if shouldLoadMore {
            guard currentPage < totalPages else {  return }
            currentPage += 1
        }else {
            resetPagination( )
        }
        
        isLoading = true
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=4d45a7ead527dc8de53cdfce48b2ec2a&page=\(currentPage)"
        NetworkManager.shared.fetchData(urlString: urlString)   { (result: Result<MovieResponse, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.totalPages = data.totalPages
                    completion(.success(data.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
}
