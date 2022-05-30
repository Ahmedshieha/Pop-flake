//
//  Parser.swift
//  Pop-flake
//
//  Created by MacBook on 30/05/2022.
//

import Foundation


struct Parser {
    
    
   private func ftechMovies (url :URL , completion : @escaping ([Movies]? , Error?) -> ()) {
       URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let data = data else {
                return
            }
            do {
                let data = try JSONDecoder().decode(DataModel.self, from: data)
                completion(data.items, nil)
                
            } catch (let error) {
                completion(nil, error)
            }

        } .resume()
   }  
    
    func fetchTopMovies (_ comp : @escaping ([Movies]? , Error?)->()) {
        let api = URL(string: UrlsApi.topMovieApi.rawValue)
        ftechMovies(url: api!) { movies, error in
            comp(movies,error)
        }
    }
    

    
    func fetchComingSoonMovies (_ comp : @escaping ([Movies]? , Error?)->()) {
        let api = URL(string: UrlsApi.commingSoon.rawValue)
        ftechMovies(url: api!) { movies, error in
            comp(movies,error)
        }
    }
    
    
    func fetchInTheatersMovies (_ comp : @escaping ([Movies]? , Error?)->()) {
        let api = URL(string: UrlsApi.InInTheaters.rawValue)
        ftechMovies(url: api!) { movies, error in
            comp(movies,error)
        }
    }
}
