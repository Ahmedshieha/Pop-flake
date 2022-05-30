//
//  HomeTableViewCell.swift
//  Pop-flake
//
//  Created by MacBook on 30/05/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var movieLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        backgroundColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
