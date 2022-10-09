//
//  TrackFetcher.swift
//  Halio
//
//  Created by Алексей Гуляев on 07.10.2022.
// https://api.jamendo.com/v3.0/tracks/?client_id=5fd6bbdc&format=jsonpretty&limit=10&search=sun

import Foundation
import Alamofire

protocol TracksFetcher {
    func didUpdateTracks(result: [Tracks])
    func didFailWithError()
}

class TrackFetcherManager {
    
    var delegate: TracksFetcher?
    
    
    
    func trackFetch(limit: Int, searchText: String) {
//        let urlString = "\(K.Api.baseUrl)/albums/tracks/?client_id=\(K.Api.clientId)&format=jsonpretty&limit=\(limit)"
        let urlString = "\(K.Api.baseUrl)/tracks/?client_id=\(K.Api.clientId)&format=jsonpretty&limit=\(limit)&search=\(searchText)"
        
        NetworkManager<TrackResponce>.fetch(from: urlString) { [weak self] (result) in
            guard let self = self else { return }
                switch result {
            case .success(let track):
                self.delegate?.didUpdateTracks(result: track.results)
            case .failure:
                self.delegate?.didFailWithError()
            }
        }
    }
}
