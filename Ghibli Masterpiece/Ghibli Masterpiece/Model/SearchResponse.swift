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
