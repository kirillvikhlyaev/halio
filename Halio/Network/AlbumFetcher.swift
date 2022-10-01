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
    
    
    
    func albumFetch(limit: Int) {
        let urlString = "\(K.Api.baseUrl)/albums/tracks/?client_id=\(K.Api.clientId)&format=jsonpretty&limit=\(limit)"
        
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
