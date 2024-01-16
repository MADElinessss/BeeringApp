//
//  APIManager.swift
//  BeeringApp
//
//  Created by Madeline on 2024/01/16.
//

import Alamofire
import Foundation

struct APIManager {
    func callRequest(completionHandler: @escaping ([Beer]) -> Void) {
        let url = "https://api.punkapi.com/v2/beers"
        AF.request(url).responseDecodable(of: [Beer].self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension APIManager {
    func fetchRandomBeer(completionHandler: @escaping (Beer?) -> Void) {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url).responseDecodable(of: [Beer].self) { response in
            switch response.result {
            case .success(let beers):
                completionHandler(beers.first)
            case .failure:
                completionHandler(nil)
            }
        }
    }
}

