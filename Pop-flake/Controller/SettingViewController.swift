//
//  SettingViewController.swift
//  Pop-flake
//
//  Created by MacBook on 01/06/2022.
//

import UIKit
import NVActivityIndicatorView
class SettingViewController: UIViewController {

    var indictor : NVActivityIndicatorView?
    
    
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        playVedio()
      indictor = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .lineSpinFadeLoader, color: .gray, padding: .none)
     showIndicator()
    }
    func showIndicator() {
        if indictor != nil {
            self.view.addSubview(indictor!)
            indictor?.startAnimating()
        }
    }
    
}
