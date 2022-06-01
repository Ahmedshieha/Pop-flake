//
//  InTheatersMovieViewModel.swift
//  Pop-flake
//
//  Created by MacBook on 31/05/2022.
//

import Foundation


class InTheatersMoviesViewModel {
    
     private let apiservice = ApiService()
    private var inTheatersMovies = [Movies]()
    
    
    
    func fetchinTheatersMovies (completion : @escaping  ()->()) {
        let url = URL(string: UrlsApi.InInTheaters.rawValue)
        apiservice.ftechData(url: url!) { [weak self] (result) in
            switch result {
            case.success(let movies):
                self?.inTheatersMovies = movies.items
                completion()
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func numberOfRowSection(section : Int) -> Int {
            return inTheatersMovies.count
    }
    
    func cellForRowAt (indexPath : IndexPath) -> Movies {
        
        return inTheatersMovies[indexPath.row]
    }
    func didSelect(indexPath : IndexPath) -> String  {
        if inTheatersMovies[indexPath.row].id != nil {
           return "https://www.imdb.com/title/\(inTheatersMovies[indexPath.row].id!)/?ref_=nv_sr_srsg_0"
        }
        return "https://www.imdb.com/title/?ref_=nv_sr_srsg_0"
    }
    
}
