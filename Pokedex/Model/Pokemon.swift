//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jake Romer on 3/28/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation

class Pokemon {
  let baseAttack: Int
  let defense: Int
  let description: String
  let height: Int
  let name: String
  let pokedexId: Int
  let type: String
  let weight: Int

  init(name: String, pokedexId: Int, baseAttack: Int,
       defense: Int, height: Int, weight: Int,
       description: String = "", type: String = "") {
    self.baseAttack = baseAttack
    self.defense = defense
    self.description = description
    self.height = height
    self.name = name
    self.pokedexId = pokedexId
    self.type = type
    self.weight = weight
  }

  static func create(collectionFrom attrs: [Dictionary<String, String>]) -> [Pokemon] {
    var newCollection = [Pokemon]()

    for entry in attrs {
      if let name = entry["identifier"],
        let id = Int(entry["id"] ?? ""),
        let height = Int(entry["height"] ?? ""),
        let weight = Int(entry["weight"] ?? ""),
        let base = Int(entry["exp"] ?? ""),
        let defense = Int(entry["defense"] ?? "") {
        let newPoke = Pokemon(name: name, pokedexId: id,
                              baseAttack: base, defense: defense,
                              height: height, weight: weight)

        newCollection.append(newPoke)
      }
    }

    return newCollection
  }
}
