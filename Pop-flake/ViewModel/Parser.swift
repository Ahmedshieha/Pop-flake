//
//  Parser.swift
//  Pop-flake
//
//  Created by MacBook on 30/05/2022.
//

import Foundation


struct Parser {
    
    
   private func ftechMovies (url :URL , completion : @escaping (Movie? , Error?) -> ()) {
       URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let data = data else {
                return
            }
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(movie, nil)
                
            } catch (let error) {
                completion(nil, error)
            }

        } .resume()
    } 
    
    func fetchTopMovies (_ comp : @escaping (Movie? , Error?)->()) {
        let api = URL(string: UrlsApi.topMovieApi.rawValue)
        ftechMovies(url: api!) { movies, error in
            comp(movies,error)
        }
    }
    
    func fetchComingSoonMovies (_ comp : @escaping (Movie? , Error?)->()) {
        let api = URL(string: UrlsApi.topMovieApi.rawValue)
        ftechMovies(url: api!) { movies, error in
            comp(movies,error)
        }
    }
    
    
    func fetchInTheatersMovies (_ comp : @escaping (Movie? , Error?)->()) {
        let api = URL(string: UrlsApi.topMovieApi.rawValue)
        ftechMovies(url: api!) { movies, error in
            comp(movies,error)
        }
    }
}
