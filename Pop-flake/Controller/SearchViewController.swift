//
//  SearchViewController.swift
//  Pop-flake
//
//  Created by MacBook on 01/06/2022.
//

import UIKit

class SearchViewController: UIViewController,UITextFieldDelegate , UICollectionViewDelegate , UICollectionViewDataSource {
    
    

    @IBOutlet weak var searchTextFiels: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextFiels.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    


}
