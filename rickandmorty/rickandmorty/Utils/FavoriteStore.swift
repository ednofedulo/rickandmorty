//
//  FavoriteStore.swift
//  rickandmorty
//
//  Created by Edno Fedulo on 06/12/20.
//  Copyright © 2020 Edno Fedulo. All rights reserved.
//

import Foundation

class FavoriteStore {
    static let defaults = UserDefaults.standard
    static func isFavorited(_ id:Int) -> Bool {
        let favorites = getAllFavorites()
        
        return favorites.contains(id)
    }
    
    static func addFavorite(_ id:Int) {
        var favorites = getAllFavorites()
        favorites.append(id)
        defaults.set(favorites, forKey: "favorites")
    }
    
    
    static func removeFavorite(_ id:Int) {
        var favorites = getAllFavorites()
        favorites = favorites.filter { $0 != id }
        defaults.set(favorites, forKey: "favorites")
    }
    
    static func getAllFavorites() -> [Int] {
        return defaults.array(forKey: "favorites") as? [Int] ?? [Int]()
    }
}
