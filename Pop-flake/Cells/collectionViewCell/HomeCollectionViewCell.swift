//
//  HomeCollectionViewCell.swift
//  Pop-flake
//
//  Created by MacBook on 30/05/2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MovieImageView: UIImageView!
    override func awakeFromNib() {
        layer.cornerRadius = 10
        backgroundColor = .white
        MovieImageView.layer.cornerRadius = 10
    }
    
    func configureCell(movies : Movies){
        self.MovieImageView.image = UIImage(named: movies.image!)
        
        guard let imageurl = URL(string: movies.image!) else {
            return
        }
        print(imageurl)
        self.MovieImageView.image = nil
        getImageDataFrom(url: imageurl)
    }
    
    func configureTest () {
        
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
                    self.MovieImageView.image = image
                }
            }
            
        }.resume()
    }
    
    
    
}
