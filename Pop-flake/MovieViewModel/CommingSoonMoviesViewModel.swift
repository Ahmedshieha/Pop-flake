//
//  CommingSoonMovies.swift
//  Pop-flake
//
//  Created by MacBook on 31/05/2022.
//

import Foundation

class CommingSoonMoviesViewModel {
    
     private let apiservice = ApiService()
    private var commingSoonMovies = [Movies]()
    
    
    
    func fetchcommingSoonMovies (completion : @escaping  ()->()) {
        let url = URL(string: UrlsApi.commingSoon.rawValue)
        apiservice.ftechData(url: url!) { [weak self] (result) in
            switch result {
            case.success(let movies):
                self?.commingSoonMovies = movies.items
                completion()
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func numberOfRowSection(section : Int) -> Int {
            return commingSoonMovies.count
    }
    
    func cellForRowAt (indexPath : IndexPath) -> Movies {
        
        return commingSoonMovies[indexPath.row]
    }
    func didSelect(indexPath : IndexPath) -> String  {
        if commingSoonMovies[indexPath.row].id != nil {
           return "https://www.imdb.com/title/\(commingSoonMovies[indexPath.row].id!)/?ref_=nv_sr_srsg_0"
        }
        return "https://www.imdb.com/title/?ref_=nv_sr_srsg_0"
    }
    
    
}
