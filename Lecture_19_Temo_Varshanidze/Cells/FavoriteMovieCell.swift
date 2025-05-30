import UIKit

class FavoriteMovieCell: UITableViewCell {

    weak var delegate: MovieRemoveDelegate?

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()

    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        return label
    }()

    let raitingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkText
        return label
    }()

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🗑️", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.yellow, for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureRemoveButton() {
        delegate?.removeMovie(cell: self)
    }

    private func setupUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(raitingLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(removeButton)

        removeButton.addAction(UIAction(handler: { [weak self] action in
            self?.configureRemoveButton()
        }), for: .touchUpInside)

   
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 145),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            genreLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            raitingLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 5), // მცირე დაშორება
            raitingLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
            raitingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            releaseDateLabel.topAnchor.constraint(equalTo: raitingLabel.bottomAnchor, constant: 5), // ქვემოთ ჩამოსმული
            releaseDateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            releaseDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            removeButton.topAnchor.constraint(equalTo: genreLabel.topAnchor, constant: -30),
            removeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
            
        ])
    }

    func configure(with movie: MovieModel) {
        titleLabel.text = movie.title
        genreLabel.text = "Genre: \(GenreManager.shared.getGenreNames(for: movie.genreIDs))"
        raitingLabel.text = "Raiting: \(movie.voteAverage)"
        releaseDateLabel.text = "Release Date: \(movie.releaseDate)"

        if let posterPath = movie.posterPath {
            let imageUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            loadImage(from: imageUrl)
        } else {
            posterImageView.image = UIImage(named: "placeholder")
        }
    }

    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
