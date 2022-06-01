//
//  Header.swift
//  Pop-flake
//
//  Created by MacBook on 31/05/2022.
//

import Foundation
import UIKit

class Header : UICollectionReusableView {
    let lable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        lable.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
        lable.font  = UIFont.boldSystemFont(ofSize: 25)
        addSubview(lable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lable.frame = bounds
    }
    
}
