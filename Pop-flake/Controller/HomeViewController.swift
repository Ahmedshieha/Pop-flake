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
    var commingSoon = [Movies]()
    var inTheaters = [Movies]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        configureTableViewCell()
        getTopMovies()
        getCommingSoonMovies()
        getInTheatersMovies()
    }
    
    
    
    private func getTopMovies() {
        parser.fetchTopMovies { data, error in
            if error != nil {
                print(error!)
            } else {
                self.movies = data!
                print(self.movies)
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
                self.commingSoon = data!
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    private func getInTheatersMovies() {
        parser.fetchInTheatersMovies { data, error in
            if error != nil {
                print(error!)
            } else {
                self.inTheaters = data!
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
        
    }
    
    
    
}
extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! HomeTableViewCell
        
        if indexPath.row == 0 {
            cell.configure(with: movies)
        } else if indexPath.row == 1 {
            cell.configure(with: commingSoon)
        } else if indexPath.row == 2 {
            cell.configure(with: inTheaters)
        }
        return cell 
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height/4
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//
//        if section == 0 {
//            headerView.backgroundColor = .gray
//        } else if section == 1 {
//            headerView.backgroundColor = .green
//        }
//
//        let lable = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 44))
//        return headerView
//    }
   
    
}
