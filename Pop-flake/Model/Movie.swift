//
//  Movie.swift
//  Pop-flake
//
//  Created by MacBook on 30/05/2022.
//

import Foundation

// MARK: - Welcome
struct Movie: Codable {
    let items: [Item]
    let errorMessage: String
}

// MARK: - Item
struct Item: Codable {
    let id : String
    let title : String
    let fullTitle : String
    let year: String
    let releaseState: String
    let image: String
    let runtimeMins : String
    let runtimeStr : String
    let plot : String
    let contentRating: String
    let imDBRating : String
    let imDBRatingCount : String
    let metacriticRating : String
    let genres: String
    let genreList: [GenreList]
    let directors: String
    let directorList: [RList]
    let stars: String
    let starList: [RList]
    
    enum CodingKeys: String, CodingKey {
        case id, title, fullTitle, year, releaseState, image, runtimeMins, runtimeStr, plot, contentRating
        case imDBRating = "imDbRating"
        case imDBRatingCount = "imDbRatingCount"
        case metacriticRating, genres, genreList, directors, directorList, stars, starList
    }
}

// MARK: - RList
struct RList: Codable {
    let id : String
    let name: String
}

// MARK: - GenreList
struct GenreList: Codable {
    let key, value: String
}
