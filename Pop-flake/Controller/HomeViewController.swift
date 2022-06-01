//
//  TestViewController.swift
//  Pop-flake
//
//  Created by MacBook on 31/05/2022.
//

import UIKit
import SafariServices
import AVFoundation
class HomeViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
    
    let topMoviesViewModel = TopMoviesViewModel()
    let commingSoonViewModel = CommingSoonMoviesViewModel()
    let inTheatersViewModel = InTheatersMoviesViewModel()
    let boxOfficeViewModel = BoxOfficeViewModel()
    let refreshControl = UIRefreshControl()
    let categoryHeaderId = "categoryHeaderId"
    let headerId = "headerId"
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCollectionViewAndCells()
        checkInternet()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func checkInternet () {
        if Reachabilty.HasConnection() {
            self.loadtopMovies()
            self.loadcommingSoonMovies()
            self.loadinTheatersMovies()
            self.loadBoxOffice()
        }
        else {
            print("no inetrnet")
            let alert = UIAlertController(title: "Error", message: "No internet Connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(action)
            self.present(alert ,animated: true)
        }
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
    func loadBoxOffice() {
        boxOfficeViewModel.fetchboxOffice { [weak self] in
            self?.moviesCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return topMoviesViewModel.numberOfRowSection(section: section)
        } else if section == 1 {
            return commingSoonViewModel.numberOfRowSection(section: section)
        }
        if section == 2 {
            return inTheatersViewModel.numberOfRowSection(section: section)
        }
        return boxOfficeViewModel.numberOfRowSection(section: section)
        
       
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
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
        } else if indexPath.section == 2 {
        let inTheatersCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioViewCell", for: indexPath) as! HomeCollectionViewCell
        let movie = inTheatersViewModel.cellForRowAt(indexPath: indexPath)
        inTheatersCell.configureCell(movie)
        return inTheatersCell
        }
        
        let boxOfficeCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        let movie = boxOfficeViewModel.cellForRowAt(indexPath: indexPath)
        boxOfficeCell.configure(movies: movie)
        return boxOfficeCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let url = topMoviesViewModel.didSelect(indexPath:indexPath)
            let viewController = SFSafariViewController(url: URL(string: url)!)
            present(viewController , animated: true)
            
        } else if indexPath.section == 1 {
            let url = commingSoonViewModel.didSelect(indexPath:indexPath)
            let viewController = SFSafariViewController(url: URL(string: url)!)
            present(viewController , animated: true)
        }
        else if indexPath.section == 2 {
        let url = inTheatersViewModel.didSelect(indexPath:indexPath)
        let viewController = SFSafariViewController(url: URL(string: url)!)
        present(viewController , animated: true)
        }
        else if indexPath.section == 3 {
        let url = boxOfficeViewModel.didSelect(indexPath:indexPath)
        let viewController = SFSafariViewController(url: URL(string: url)!)
        present(viewController , animated: true)
        }
        
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
         else if indexPath.section == 2 {
         let inTheatersHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
                 inTheatersHeader.lable.text = "In Theaters"
             return inTheatersHeader
         }
         
         let boxOffice = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
             boxOffice.lable.text = "Top Grossing"
         return boxOffice
         
         
         
    }
    
    func configureCollectionViewAndCells() {
        
        moviesCollectionView.collectionViewLayout = createCompostionalLayout()
        moviesCollectionView.register(Header.self, forSupplementaryViewOfKind: categoryHeaderId, withReuseIdentifier: headerId)
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectioViewCell")
        self.moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moviesCollectionViewCell")
    }
    func createCompostionalLayout () -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {( sectionNumber , env ) -> NSCollectionLayoutSection? in
            if sectionNumber == 3 {
                return self.boxOfficemoviesLayoutSection()
            }
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
        
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)) , elementKind  : categoryHeaderId , alignment : .top )]
        section.contentInsets = .init(top: 5, leading: 20, bottom: 5, trailing: 5)
        
        
        return section
        
    }
    func boxOfficemoviesLayoutSection () -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 5 , leading: 5, bottom: 5, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior  = .none
        
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)) , elementKind  : categoryHeaderId , alignment : .top )]
        section.contentInsets = .init(top: 5, leading: 20, bottom: 5, trailing: 5)
        return section
        
    }
    
}


