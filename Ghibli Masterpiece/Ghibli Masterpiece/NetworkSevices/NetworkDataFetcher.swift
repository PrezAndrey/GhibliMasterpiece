//
//  NetworkDataFetcher.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 02.09.2022.
//

import Foundation

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    // MARK: DATA Fetcher
    
    
    func fetchFilmArray(urlString: String, response: @escaping ([Film]?) -> Void) {
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
    
    func fetchFilmData(urlString: String, response: @escaping (Film?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let info = try JSONDecoder().decode(Film.self, from: data)
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
    
    // Fetching people data
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
    
    func fetchPeopleArray(urlString: String, response: @escaping ([People]?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let info = try JSONDecoder().decode([People].self, from: data)
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
    
    // Fetching species data
    func fetchSpeciesData(urlString: String, response: @escaping (Species?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let info = try JSONDecoder().decode(Species.self, from: data)
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
    
    // Fetching location data
    func fetchLocationData(urlString: String, response: @escaping (Location?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let info = try JSONDecoder().decode(Location.self, from: data)
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
    
    func fetchLocationArray(urlString: String, response: @escaping ([Location]?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let info = try JSONDecoder().decode([Location].self, from: data)
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
    
    func fetchVehicleArray(urlString: String, response: @escaping ([Vehicle]?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let info = try JSONDecoder().decode([Vehicle].self, from: data)
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
    
    func fetchVehicleData(urlString: String, response: @escaping (Vehicle?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let info = try JSONDecoder().decode(Vehicle.self, from: data)
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
