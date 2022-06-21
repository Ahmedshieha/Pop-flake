//
//  MoviesCollectionViewCell.swift
//  Pop-flake
//
//  Created by MacBook on 01/06/2022.
//

import UIKit
import Kingfisher
class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
    
    }
    
    func updateUI (imageUrl : String) {
        guard let imageUrl = URL(string: imageUrl) else {
            return
        }
        self.movieImageView.image = nil
//        getImageDataFrom(url: imageUrl)
        kingFisherImage(url: imageUrl)
    }
    
    func configure(movies : Movies ) {
        titleMovieLable.text = movies.title
//        movieYear.text = movies.resultDescription
    
        updateUI(imageUrl: movies.image!)
           
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
                } else {
                    self.movieImageView.image = UIImage(named: "No-Image-Placeholder.svg")
                }
            }

        }.resume()
    }
    
    func kingFisherImage (url:URL) {
        let processor = DownsamplingImageProcessor(size: movieImageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 5)
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }

}
