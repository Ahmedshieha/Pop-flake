//
//  MoviesCollectionViewCell.swift
//  Pop-flake
//
//  Created by MacBook on 01/06/2022.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLable: UILabel!
    @IBOutlet weak var rateMovieLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func updateUI (imageUrl : String) {
        guard let imageUrl = URL(string: imageUrl) else {
            return
        }
        self.movieImageView.image = nil
        getImageDataFrom(url: imageUrl)
    }
    
    func configure(movies : SearchMovies ) {
        titleMovieLable.text = movies.title
        updateUI(imageUrl: movies.image)
           
    }
    
    private func getImageDataFrom(url :URL) {
        URLSession.shared.dataTask(with: url) { data, respomse, error in

            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                print("empty")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.movieImageView.image = image
                }
            }

        }.resume()
    }

}
