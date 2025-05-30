

import UIKit

class MovieDetailViewController: UIViewController {
    let detailTableView = UITableView()
     var movieID: Int?
    private var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAllFunctions()
       
    }
    
    func callAllFunctions(){
        view.backgroundColor = .systemBackground
        setUpTableView()
        setUpUI()
    }
    
    func setUpTableView() {
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailTableView)
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.register(MovieDetailCell.self, forCellReuseIdentifier: "MovieDetailCell")
        detailTableView.backgroundColor = .cyan
        
        
        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            detailTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            detailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            detailTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0)
        ])
    }
    
    func setUpUI(){
        viewModel = MovieDetailViewModel()
        viewModel.onDetailUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.detailTableView.reloadData()
            }
        }
        viewModel.onErrorReceived = { [weak self] error in
            DispatchQueue.main.async {
                self?.showError(error)
            }
        }
        if let movieID = movieID {
            viewModel.fetchMovieDetail(movieId: movieID)
        }
    }
    private func showError(_ error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as! MovieDetailCell
        if let movie = viewModel.movieDetails {
            cell.configure(with: movie)
        }
        cell.backgroundColor = UIColor(
            red: CGFloat.random(in: 0.5...1),
            green: CGFloat.random(in: 0.5...1),
            blue: CGFloat.random(in: 0.5...1),
            alpha: 1.0
        )
        return cell
    }
}
