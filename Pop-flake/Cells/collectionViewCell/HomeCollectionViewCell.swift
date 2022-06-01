//
//  HomeCollectionViewCell.swift
//  Pop-flake
//
//  Created by MacBook on 30/05/2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
  
    override func awakeFromNib() {
        layer.cornerRadius = 10
        backgroundColor = .white
        movieImageView.layer.cornerRadius = 10
    }
    
    func updatUi(imageUrlString : String) {
        
        guard let imageUrl = URL(string: imageUrlString ) else {
            return
        }
        self.movieImageView.image = nil
        getImageDataFrom(url: imageUrl)
    }
    
    func configureCell(_ movies : Movies){
        updatUi(imageUrlString: movies.image!)
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
    
    
    
}
