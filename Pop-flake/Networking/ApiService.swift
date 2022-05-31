//
//  ApiService.swift
//  Pop-flake
//
//  Created by MacBook on 31/05/2022.
//

import Foundation


class ApiService {

     func ftechData (url : URL , completion : @escaping (Result<DataModel, Error>) -> Void) {

        URLSession.shared.dataTask(with: url) { (data, response, error) in
             if let error = error {
                 completion(.failure(error))
                 print(error)
                 return
             }
             guard let response = response as? HTTPURLResponse else {
                 return
             }
            print(response.statusCode)

            guard let data = data else {
            print("Empty Data")
                return
            }

             do {
                 let jsonData = try JSONDecoder().decode(DataModel.self, from: data)

                 DispatchQueue.main.async {
                     completion(.success(jsonData))

                 }
             }
            
                 catch let error {
                 completion(.failure(error))
             }
        }.resume()
    }


}
