//
//  TvModel.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import Foundation

struct TvModel: Decodable {
    let page: Int
    let results: [TV]
}

struct TV: Decodable {
    let id: Int
    let name: String
    let original_name: String
    let overview: String
    let average: Double?
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case original_name
        case overview
        case average = "vote_average"
        case poster = "poster_path"
    }
}

struct SeasonModel: Decodable {
    let seasons: [Season]
    let original_language: String
}

struct Season: Decodable {
    let air_date: String
    let episode_count: Int
    let name: String
    let overview: String
    let poster_path: String
    let season_number: Int
    let vote_average: Int
}


struct ActorModel: Decodable {
    let cast: [Actor]
}

struct Actor: Decodable {
    let name: String
    let roles: [RoleCharacter]
}

struct RoleCharacter: Decodable {
    let character: String
}
