//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jake Romer on 3/28/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
  let pokedexId: Int
  let name: String
  let url: String

  var baseAttack: Int?
  var defense: Int?
  var description: String?
  var height: Int?
  var type: String?
  var weight: Int?

  init(name: String, pokedexId: Int) {
    self.name = name
    self.pokedexId = pokedexId
    self.url = "\(API_URL)/\(pokedexId)/"
  }

  func downloadDetails(completion: @escaping DownloadComplete) {
    Alamofire.request(url).responseJSON { (resp) in
      guard let json = resp.result.value as? [String: Any]
        else { return }

      guard let baseAttack = json["attack"] as? Int,
        let defense = json["defense"] as? Int,
        let height = json["height"] as? String,
        let weight = json["weight"] as? String
        else { return completion(nil) }

      self.baseAttack = baseAttack
      self.defense = defense
      self.height = Int(height)
      self.weight = Int(weight)

      completion(self)
    }
  }

  static func create(collectionFrom attrs: [Dictionary<String, String>]) -> [Pokemon] {
    var newCollection = [Pokemon]()

    for entry in attrs {
      if let name = entry["identifier"],
        let id = Int(entry["id"] ?? "") {
        newCollection.append(Pokemon(name: name, pokedexId: id))
      }
    }

    return newCollection
  }
}
