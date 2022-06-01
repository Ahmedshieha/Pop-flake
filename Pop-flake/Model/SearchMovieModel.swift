//
//  SearchMovieModel.swift
//  Pop-flake
//
//  Created by MacBook on 01/06/2022.
//

import Foundation


struct SearchData: Codable {
    let searchType, expression: String
    let results: [Movies]
    let errorMessage: String
}


