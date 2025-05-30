import UIKit

class MovieDetailCell: UITableViewCell {
    
   
    private let titleLabel = UILabel()
    private let overviewLabel = UILabel()
    private let posterImageView = UIImageView()
    private let directorLabel = UILabel()
    private let durationLabel = UILabel()
    private let authorLabel = UILabel()
    private let sourceTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setupUI()
    }
    
    private func setupUI() {
        [titleLabel, overviewLabel, posterImageView, directorLabel, durationLabel, authorLabel, sourceTitleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = .darkGray
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        
        directorLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        durationLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        authorLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        sourceTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        directorLabel.textColor = .systemBlue
        durationLabel.textColor = .systemBlue
        authorLabel.textColor = .systemBlue
        sourceTitleLabel.textColor = .systemBlue
        
       
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            overviewLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            overviewLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            directorLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10),
            directorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            directorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            durationLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 5),
            durationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            durationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            authorLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 5),
            authorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            sourceTitleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            sourceTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            sourceTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            sourceTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}

extension MovieDetailCell: JsonMovieDetailDelegate {
    func configure(with movie: MovieDetailModel) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        durationLabel.text = "Duration: \(movie.duration ?? 0) min"        
        if let posterPath = movie.posterPath, !posterPath.isEmpty {
            let imageUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            loadImage(from: imageUrl)
        }
    }
}
