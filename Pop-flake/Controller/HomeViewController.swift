//
//  HomeViewController.swift
//  Pop-flake
//
//  Created by MacBook on 30/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    
    let dataModel = [DataModel]()
    let parser = Parser()
    var movies = [Movies]()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        configureTableViewCell()
        
        getTopMovies()
    }
    
    private func getTopMovies() {
        parser.fetchTopMovies { data, error in
            if error != nil {
                print(error!)
            } else {
                self.movies = data!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    
    private func getCommingSoonMovies() {
        parser.fetchComingSoonMovies { data, error in
            if error != nil {
                print(error!)
            } else {
                self.movies = data!
                print(self.movies.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    private func getInTheatersMovies() {
        parser.fetchComingSoonMovies { data, error in
            if error != nil {
                print(error!)
            } else {
                self.movies = data!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    
    func configureTableViewCell () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        tableView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellReuseIdentifier: "collectioViewCell")
    }
    
    
    
}
extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! HomeTableViewCell
        cell.backgroundColor = .white
        cell.movieLable.text = movies[indexPath.row].title
        
        return cell 
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
