//
//  CatAPI_Helper.swift
//  thecatapi
//
//  Created by test on 2022-10-18.
//

import Foundation

enum CatBreedsData{
    case success(CatBreeds)
    case failure(Error)
}

class CatAPI_Helper {
    private static let baseURL = URL(string: "https://api.thecatapi.com/v1/breeds")!
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    static func fetchCats(callback: @escaping (CatBreedsData)->Void){
        let request = URLRequest(url: baseURL)
        let task = session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let catBreeds = try decoder.decode(CatBreeds.self, from: data)

                    callback(.success(catBreeds))
                    
                } catch let e {
                    callback(.failure(e))
                }
            } else if let error = error {
                callback(.failure(error))
            }
        }
        task.resume()
    }
}
