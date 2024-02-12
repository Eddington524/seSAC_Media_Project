//
//  ProfileImgModel.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/12/24.
//

import Foundation

struct ProfileImgModel: Decodable {
    let total, start, display: Int
    let items: [Info]
}

struct Info: Decodable {
    let title: String
    let link: String
    let thumbnail: String?
}
