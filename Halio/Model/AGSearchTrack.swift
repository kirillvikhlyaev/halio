//
//  AGSearchTrack.swift
//  Halio
//
//  Created by Алексей Гуляев on 07.10.2022.
//https://api.jamendo.com/v3.0/tracks/?client_id=5fd6bbdc&format=jsonpretty&limit=10&search=sun

import Foundation

// MARK: - Welcome
struct TrackResponce: Codable {
    let results: [Tracks]
}

// MARK: - Tracks
struct Tracks: Codable {
    let name: String
    let duration: Int
    let artistName, albumName: String
    let albumImage, audio: String
    let waveform: String
    let image: String
    let audiodownloadAllowed: Bool

    enum CodingKeys: String, CodingKey {
        case name, duration
        case artistName = "artist_name"
        case albumName = "album_name"
        case albumImage = "album_image"
        case audio, waveform, image
        case audiodownloadAllowed = "audiodownload_allowed"
    }
}

