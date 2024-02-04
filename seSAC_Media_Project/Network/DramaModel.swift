//
//  TvModel.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import Foundation

struct DramaModel: Decodable {
    let page: Int
    let results: [Drama]
}

struct Drama: Decodable {
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
    let backdrop_path: String?
    let seasons: [Season]
    let original_language: String
    let overview: String?
}

struct Season: Decodable {
    let air_date: String?
    let episode_count: Int
    let name: String
    let overview: String?
    let poster_path: String?
    let season_number: Int
    let vote_average: Double
    
    enum CodingKeys: CodingKey {
        case air_date
        case episode_count
        case name
        case overview
        case poster_path
        case season_number
        case vote_average
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.air_date = try container.decodeIfPresent(String.self, forKey: .air_date) ?? ""
        self.episode_count = try container.decode(Int.self, forKey: .episode_count)
        self.name = try container.decode(String.self, forKey: .name)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path) ?? ""
        self.season_number = try container.decode(Int.self, forKey: .season_number)
        self.vote_average = Double(try container.decode(Double.self, forKey: .vote_average))
    }
}


struct ActorModel: Decodable {
    let cast: [Actor]
}

struct Actor: Decodable {
    let name: String
    let roles: [RoleCharacter]
    let profile_path: String?
}

struct RoleCharacter: Decodable {
    let character: String
}
