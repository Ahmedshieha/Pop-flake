//
//  BoxOffice.swift
//  Pop-flake
//
//  Created by MacBook on 01/06/2022.
//

import Foundation
import UIKit
import SafariServices

class BoxOfficeViewModel {
private var apiService = ApiService()
private var boxOffice = [Movies]()


func fetchboxOffice (completion : @escaping  ()->()) {
    let url = URL(string: UrlsApi.topBoxing.rawValue)
    apiService.ftechData(url: url!) { [weak self] (result) in
        switch result {
        case.success(let movies):
            self?.boxOffice = movies.items
            completion()
        case.failure(let error):
            print(error.localizedDescription)
        }
    }
}

func numberOfRowSection(section : Int) -> Int {
        return boxOffice.count
}

func cellForRowAt (indexPath : IndexPath) -> Movies {
    
    return boxOffice[indexPath.row]
}

func didSelect(indexPath : IndexPath) -> String  {
    if boxOffice[indexPath.row].id != nil {
       return "https://www.imdb.com/title/\(boxOffice[indexPath.row].id!)/?ref_=nv_sr_srsg_0"
    }
    return "https://www.imdb.com/title/?ref_=nv_sr_srsg_0"
}
    
}
