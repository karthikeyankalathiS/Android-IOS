//
//  MovieList.swift
//  MovieList
//
//  Created by karthik on 19/02/24.
//

import UIKit

class MovieList: UITableViewCell {

    @IBOutlet var List: UICollectionView!
    var movie = [MovieListResponse]()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.List.register(UINib(nibName: "Movies", bundle: nil), forCellWithReuseIdentifier: "Movies")
        self.List.delegate = self
        self.List.dataSource = self
        fetchingData()
    }

    func fetchingData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=9c0523bff54071c4fb4b716a950231b9&language=en-US&page=1&region=IN%7CUS&with_release_type=2%7C3") else {
            return
        }

        ApiManager.fetchMovieList(from: url) { (result: Result<MovieListResponse, Error>) in
            switch result {
            case .success(let movieListResponse):
                self.movie = [movieListResponse]
                DispatchQueue.main.async {
                    self.List.reloadData()
                }
            case .failure(let error):
                print("Fetching data error: \(error.localizedDescription)")
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MovieList: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count > 0 ? movie[0].results.count : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Movies", for: indexPath) as! Movies
        guard let dataCell = movie.first?.results[indexPath.item] else {
            return cell
        }

        cell.MovieName.text = dataCell.originalTitle
        cell.Year.text = dataCell.releaseDate.components(separatedBy: "-").first
        let urlString = "https://image.tmdb.org/t/p/w780" + (dataCell.posterPath )
        let url = URL(string: urlString)
        cell.Image.downloaded(from: url!, contentMode: .scaleToFill)
        return cell
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType,
                  mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }

    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
