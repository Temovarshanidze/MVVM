import UIKit

class MovieListViewController: UIViewController {
    
    private let topRatedMoviesTableView = UITableView()
    private let viewModel: MovieListViewModel
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movies"
        
        callAllFunctions()
    }
    
    func callAllFunctions() {
        setupUI()
        fetchTopRatedMovies()
        
        // clearSavedMovies()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBlue
        
        topRatedMoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        topRatedMoviesTableView.dataSource = self
        topRatedMoviesTableView.delegate = self
        topRatedMoviesTableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        view.addSubview(topRatedMoviesTableView)
        
        NSLayoutConstraint.activate([
            topRatedMoviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topRatedMoviesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            topRatedMoviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            topRatedMoviesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func fetchTopRatedMovies() {
        viewModel.fetchMovies()
        viewModel.loadSavedMovies()
        
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.topRatedMoviesTableView.reloadData()
            }
        }
    }
    
    private func loadMoreMovies() {
        viewModel.fetchMovies(loadMore: true)
    }
    
    
    
    func clearSavedMovies() {
        viewModel.deleteSavedMovies()
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = viewModel.movie(at: indexPath.row)
        cell.configure(with: movie)
        cell.delegate = self
        
        cell.backgroundColor = UIColor(
            red: CGFloat.random(in: 0.5...1),
            green: CGFloat.random(in: 0.5...1),
            blue: CGFloat.random(in: 0.5...1),
            alpha: 1.0
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movie(at: indexPath.row)
        let detailViewController = MovieDetailViewController()
        detailViewController.movieID = selectedMovie.id
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 2 {
            loadMoreMovies()
        }
    }
}

extension MovieListViewController: MovieAddDelegate {
    func addMovie(cell: MovieCell) {
        if let indexPath = topRatedMoviesTableView.indexPath(for: cell) {
            let movie = viewModel.movies[indexPath.row]
            viewModel.addFavoriteMovie(movie: movie) {
            }
        }
    }
}
