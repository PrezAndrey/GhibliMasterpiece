//
//  NetworkDataFetcher.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 02.09.2022.
//

import Foundation

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    // dataFetcher
    func fetchData(urlString: String, response: @escaping ([Film]?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let info = try JSONDecoder().decode([Film].self, from: data)
                    response(info)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
                
            case .failure(let error):
                print("Error recieved requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func fetchPeopleData(urlString: String, response: @escaping (People?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let info = try JSONDecoder().decode(People.self, from: data)
                    response(info)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
                
            case .failure(let error):
                print("Error recieved requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
