//
//  TestViewController.swift
//  Pop-flake
//
//  Created by MacBook on 31/05/2022.
//

import UIKit

class HomeViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
    
    let topMoviesViewModel = TopMoviesViewModel()
    let commingSoonViewModel = CommingSoonMoviesViewModel()
    let inTheatersViewModel = InTheatersMoviesViewModel()
    
    let categoryHeaderId = "categoryHeaderId"
    let headerId = "headerId"
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureCollectionViewAndCells()
//        loadtopMovies()
//        loadcommingSoonMovies()
//        loadinTheatersMovies()
        moviesCollectionView.backgroundColor = .black
        
    }
    
    func configureCollectionViewAndCells() {
        
        moviesCollectionView.collectionViewLayout = createCompostionalLayout()
        moviesCollectionView.register(Header.self, forSupplementaryViewOfKind: categoryHeaderId, withReuseIdentifier: headerId)
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectioViewCell")
    }
    
    func loadtopMovies() {
        topMoviesViewModel.fetchTopMovies { [weak self] in
            self?.moviesCollectionView.reloadData()
        }
    }
    func loadcommingSoonMovies() {
        commingSoonViewModel.fetchcommingSoonMovies { [weak self] in
            self?.moviesCollectionView.reloadData()
        }
    }
    func loadinTheatersMovies() {
        inTheatersViewModel.fetchinTheatersMovies { [weak self] in
            self?.moviesCollectionView.reloadData()
        }
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return topMoviesViewModel.numberOfRowSection(section: section)
        } else if section == 1 {
            return commingSoonViewModel.numberOfRowSection(section: section)
        }
        
        return inTheatersViewModel.numberOfRowSection(section: section)
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let topMovieCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioViewCell", for: indexPath) as! HomeCollectionViewCell
            let movie = topMoviesViewModel.cellForRowAt(indexPath: indexPath)
            topMovieCell.configureCell(movie)
            return topMovieCell
        } else if indexPath.section == 1 {
            let commingSoonCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioViewCell", for: indexPath) as! HomeCollectionViewCell
            let movie = commingSoonViewModel.cellForRowAt(indexPath: indexPath)
            commingSoonCell.configureCell(movie)
            return commingSoonCell
        }
        let inTheatersCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioViewCell", for: indexPath) as! HomeCollectionViewCell
        let movie = inTheatersViewModel.cellForRowAt(indexPath: indexPath)
        inTheatersCell.configureCell(movie)
        return inTheatersCell
        
    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         
         if indexPath.section == 0 {
             let topMoviesHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
             topMoviesHeader.lable.text = "Top Movies"
             
            return topMoviesHeader
         }
         else if indexPath.section == 1{
             let commingSoonHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
                 commingSoonHeader.lable.text = "Comming Soon"
             return commingSoonHeader
         }
         
         let inTheatersHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
             inTheatersHeader.lable.text = "In Theaters"
         return inTheatersHeader
         
         
         
    }
    func createCompostionalLayout () -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {( sectionNumber , env ) -> NSCollectionLayoutSection? in
            return self.movieCellLayout()
        }
        
    }
    
    
    
    func movieCellLayout () -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 10 , leading: 5, bottom: 10, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior  = .groupPaging
        
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)) , elementKind  : categoryHeaderId , alignment : .top)]
        return section
        
    }
    
    
    
    
}


