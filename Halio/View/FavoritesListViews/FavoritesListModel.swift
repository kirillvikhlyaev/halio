//
//  FavoritesListModel.swift
//  Halio
//
//  Created by mac on 27.09.2022.
//

import UIKit

struct FavoritesListModel {
    
    static var favoritesSongs = ["Hit the lights","Safe and sound","Shut up and dance","Cake","Tonight","Sweet Bitter","Lush life","Ocean drive ","Shake it off","Reality","Sweet Babe"]
    
    static var favoritesAutors = ["Selena Gomez","Capital cities","Walk The Moon","DNCE","Daniel Blume","Kush Kush","Zara Larsson","Duke Dumont","Taylor Swift","Lost frequencies","HDMI"]
    
    static func addComposition(song: String, autor: String) {
        favoritesSongs.append(song)
        favoritesAutors.append(autor)
    }
    static func deleteComposition(index: Int) {
        favoritesSongs.remove(at: index)
        favoritesAutors.remove(at: index)
    }
}
