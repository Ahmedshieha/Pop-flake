//
//  SearchViewController.swift
//  Pop-flake
//
//  Created by MacBook on 01/06/2022.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController,UITextFieldDelegate , UICollectionViewDelegate , UICollectionViewDataSource {
    
      var movies =  [SearchMovies]()

    @IBOutlet weak var searchTextFiels: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextFiels.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self

        // Do any additional setup after loading the view.
        self.searchCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moviesCollectionViewCell")
        searchCollectionView.collectionViewLayout = createCompostionalLayout()
    }
    
    func searchMovies() {
        searchTextFiels.resignFirstResponder()

        guard let text = searchTextFiels.text , !text.isEmpty else {return}

        movies.removeAll()
        URLSession.shared.dataTask(with: URL(string: "https://imdb-api.com/en/API/SearchMovie/k_77btgszr/\(text)")!) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            var result : SearchData?
            do {
                result = try JSONDecoder().decode(SearchData.self, from: data)

            } catch let error {
                print(error)
            }
            guard let finishResult = result else {
                print("emptyData")
                return
            }
            let newMovies = finishResult.results
            self.movies.append(contentsOf: newMovies)

            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
            }

        }.resume()
    }
//    func ftechData ( completion : @escaping (Result<SearchData, Error>) -> Void) {
//                searchTextFiels.resignFirstResponder()
//
//                guard let text = searchTextFiels.text , !text.isEmpty else {return}
//
//                movies.removeAll()
//
//        URLSession.shared.dataTask(with: URL(string: "https://imdb-api.com/en/API/SearchAll/k_77btgszr/inception")!) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//                print(error)
//                return
//            }
//            guard let response = response as? HTTPURLResponse else {
//                return
//            }
//           print(response.statusCode)
//
//           guard let data = data else {
//           print("Empty Data")
//               return
//           }
//
//            do {
//                let jsonData = try JSONDecoder().decode(SearchData.self, from: data)
//
//                DispatchQueue.main.async {
//                    completion(.success(jsonData))
////                    print(jsonData.results.first?.title)
//                }
//            }
//
//                catch let error {
//                completion(.failure(error))
//            }
//       }.resume()
//   }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
//        ftechData { result in
//
//        }
        return true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        movieCell.configure(movies: movies[indexPath.row])
        return movieCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = "https://www.imdb.com/title/\(movies[indexPath.row].id)/?ref_=nv_sr_srsg_0"
        let viewController = SFSafariViewController(url:URL(string: url)!)
        present(viewController ,animated: true)
    }
    
    
    
    private func createCompostionalLayout () -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout {( sectionNumber , env ) -> NSCollectionLayoutSection? in
            
            return self.moviesLayoutSection()
    }
    
}
    func moviesLayoutSection () -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 5 , leading: 5, bottom: 5, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior  = .none
        
        return section
        
    }

}
