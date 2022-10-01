//
//  AlbumFetcher.swift
//  Halio
//
//  Created by Кирилл on 01.10.2022.
//

import Foundation
import Alamofire

protocol AlbumFetcher {
    func didUpdateAlbums(_ albumManager: AlbumFetcherManager, albums: [Album])
    func didFailWithError(error: Error)
}

class AlbumFetcherManager {
    
    var albums = [Album]()
    var delegate: AlbumFetcher?
    
    let urlString = "https://api.jamendo.com/v3.0/albums/tracks/?client_id=\(K.Api.clientId)&format=jsonpretty&limit=6"
    
    func albumFetch() {
        NetworkManager<AlbumResponse>.fetch(from: urlString) {
            (result) in
            switch result {
            case .success(let responce):
                self.albums = responce.results
                print(responce.results.count)
                self.delegate?.didUpdateAlbums(self, albums: self.albums)
            case .failure(let err):
                self.delegate?.didFailWithError(error: err)
            }
        }
    }
}
