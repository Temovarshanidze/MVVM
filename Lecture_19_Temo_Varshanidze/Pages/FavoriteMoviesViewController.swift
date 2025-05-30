
import UIKit

class FavoriteMoviesViewController: UIViewController {
    
     let favoriteMoviesTableView = UITableView()
    var moviemodel: MovieListViewModel
    
    init(moviemodel: MovieListViewModel){
        self.moviemodel = moviemodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favorite Movies"
        setupUI()
        fetchfavoriteMovie()
        

    }

    func fetchfavoriteMovie(){
        self.moviemodel.onMoviesFavoritUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.favoriteMoviesTableView.reloadData()
            }
        }
    }
    

    
    private func setupUI() {
        view.backgroundColor = .systemBlue
        favoriteMoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        favoriteMoviesTableView.dataSource = self
        favoriteMoviesTableView.delegate = self
        favoriteMoviesTableView.register(FavoriteMovieCell.self, forCellReuseIdentifier: "FavoriteMovieCell")
        view.addSubview(favoriteMoviesTableView)
        
        NSLayoutConstraint.activate([
            favoriteMoviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteMoviesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            favoriteMoviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoriteMoviesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        
    }
    
    
    
}
    
    extension FavoriteMoviesViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return moviemodel.numberOfFavoriteMovies
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell", for: indexPath) as! FavoriteMovieCell
            let movie = moviemodel.favoriteMovies[indexPath.row]
            cell.delegate = self
            cell.configure(with: movie)
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
            let selectedMovie = moviemodel.favoriteMovies[indexPath.row]
            let detailViewController = MovieDetailViewController()
            detailViewController.movieID = selectedMovie.id
            navigationController?.pushViewController(detailViewController, animated: true)
          }
          
    }
    
    extension FavoriteMoviesViewController: MovieRemoveDelegate {
        func removeMovie(cell: FavoriteMovieCell) {
            if let index = favoriteMoviesTableView.indexPath(for: cell) {
                moviemodel.favoriteMovies.remove(at: index.row )
                self.favoriteMoviesTableView.reloadData()
                print(moviemodel.favoriteMovies.count)
            }
        }
    }




