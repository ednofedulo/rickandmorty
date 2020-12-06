//
//  DetailViewModel.swift
//  rickandmorty
//
//  Created by Edno Fedulo on 05/12/20.
//  Copyright © 2020 Edno Fedulo. All rights reserved.
//

import Foundation

protocol DetailViewModelViewDelegate:AnyObject {
    
}

class DetailViewModel: DetailViewModelViewDelegate {
    
    var model:CharacterModel?
    
    init(character:CharacterModel) {
        self.model = character
    }
    
    func toggleFavoriteCharacter() {
        
        guard let model = model else { return }
        if self.model?.isFavorited == nil {
            self.model?.isFavorited = true
        } else {
            self.model?.isFavorited?.toggle()
        }
        
        if self.model?.isFavorited == true {
            FavoriteStore.addFavorite(model.id!)
        } else {
            FavoriteStore.removeFavorite(model.id!)
        }
    }
}
