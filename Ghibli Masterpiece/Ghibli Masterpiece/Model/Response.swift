//
//  Seatr.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 02.09.2022.
//

import Foundation

struct Film: Decodable {
    
    var id: String?
    var title: String?
    var original_title: String?
    var original_title_romanised: String?
    var image: String?
    var movie_banner: String?
    var description: String?
    var director: String?
    var producer: String?
    var release_date: String?
    var runnung_time: String?
    var people: [String]?
    var species: [String]?
    var locations: [String]?
    var vehicles: [String]?
}

struct People: Decodable {
    
    var id: String?
    var name: String?
    var gender: String?
    var age: String?
    var eye_color: String?
    var hair_color: String?
    var films: [String]?
    var species: String?
    var url: String?
}

struct Location: Decodable {
    
    var id: String?
    var name: String?
    var climat: String?
    var terrain: String?
    var surface_water: String?
    var residents: [String]?
    var films: [String]?
    var url: String?
}

struct Vehicle: Decodable {
    
    var id: String?
    var name: String?
    var description: String?
    var vehicle_class: String?
    var length: String?
    var pilot: String?
    var films: [String]?
    var url: String?
}

struct Species: Decodable {
    
    var id: String?
    var name: String?
    var classification: String?
    var eye_color: String?
    var hair_color: String?
    var people: [String]?
    var films: [String]?
    var url: String?
}
