//
//  SearchMovieModel.swift
//  Pop-flake
//
//  Created by MacBook on 01/06/2022.
//

import Foundation


struct SearchData: Codable {
    let searchType, expression: String
    let results: [SearchMovies]
    let errorMessage: String
}

// MARK: - Result
struct SearchMovies: Codable {
    let id, resultType: String
    let image: String
    let title, resultDescription: String

    enum CodingKeys: String, CodingKey {
        case id, resultType, image, title
        case resultDescription = "description"
    }
}
