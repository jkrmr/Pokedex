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
    self.url = "\(API_URL)/\(pokedexId)"
  }

  func downloadDetails(completion: @escaping DownloadComplete) {
    Alamofire.request(url).responseJSON { (resp) in
      print(resp.result.value ?? "no response")
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
