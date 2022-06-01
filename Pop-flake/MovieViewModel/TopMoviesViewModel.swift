//
//  Parser.swift
//  Pop-flake
//
//  Created by MacBook on 30/05/2022.
//

import Foundation
import UIKit
import SafariServices

class TopMoviesViewModel {
    
    private var apiService = ApiService()
    private var topMovies = [Movies]()
    
    
    func fetchTopMovies (completion : @escaping  ()->()) {
        let url = URL(string: UrlsApi.topMovieApi.rawValue)
        apiService.ftechData(url: url!) { [weak self] (result) in
            switch result {
            case.success(let movies):
                self?.topMovies = movies.items
                completion()
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    func numberOfRowSection(section : Int) -> Int {
            return topMovies.count
    }
    
    func cellForRowAt (indexPath : IndexPath) -> Movies {
        
        return topMovies[indexPath.row]
    }
    
    func didSelect(indexPath : IndexPath) -> String  {
        if topMovies[indexPath.row].id != nil {
           return "https://www.imdb.com/title/\(topMovies[indexPath.row].id!)/?ref_=nv_sr_srsg_0"
        }
        return "https://www.imdb.com/title/?ref_=nv_sr_srsg_0"
    }
}
