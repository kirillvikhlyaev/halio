//
//  Album.swift
//  Halio
//
//  Created by Кирилл on 01.10.2022.
//

import Foundation

struct AlbumResponse: Codable {
    var results: [Album]
}

struct Album: Codable {
    let id : String
    let name : String
    let artist_name: String
    let image : String
    let tracks: [Track]
}
