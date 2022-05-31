//
//  Parser.swift
//  Pop-flake
//
//  Created by MacBook on 30/05/2022.
//

import Foundation


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
    
}
