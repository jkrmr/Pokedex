//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jake Romer on 3/28/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation

class Pokemon {
  let name: String
  let pokedexId: Int

  init(name: String, pokedexId: Int) {
    (self.name, self.pokedexId) = (name, pokedexId)
  }

  static func create(collectionFrom attrs: [Dictionary<String, String>]) -> [Pokemon] {
    var newCollection = [Pokemon]()
    
    for entry in attrs {
      if let name = entry["identifier"], let idString = entry["id"], let id = Int(idString) {
        let newPoke = Pokemon(name: name, pokedexId: id)
        newCollection.append(newPoke)
      }
    }

    return newCollection
  }
}
