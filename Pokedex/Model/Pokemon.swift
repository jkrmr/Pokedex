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
  var evolutionName: String?
  var evolutionID: String?

  init(name: String, pokedexId: Int) {
    self.name = name
    self.pokedexId = pokedexId
    self.url = "\(API_URL)/\(pokedexId)/"
  }

  func downloadDetails(completion: @escaping DownloadComplete) {
    OperationQueue().addOperation {
      Alamofire.request(self.url).responseJSON { (resp) in
        guard let json = resp.result.value as? [String: AnyObject]
          else { return OperationQueue.main.addOperation { completion(nil) }}

        if let baseAttack = json["attack"] as? Int64 {
          self.baseAttack = Int(baseAttack)
        }

        if let defense = json["defense"] as? Int64 {
          self.defense = Int(defense)
        }

        if let height = json["height"] as? Int64 {
          self.height = Int(height)
        }

        if let weight = json["weight"] as? Int64 {
          self.weight = Int(weight)
        }

        if let types = json["types"] as? [[String: AnyObject]], types.count > 0 {
          let typenames = types.flatMap({ type -> String in
            guard let typeData = type["type"] as? [String: String] else { return "" }
            return typeData["name"]?.capitalized ?? ""
          })
          self.type = typenames.joined(separator: " / ")
        }

        OperationQueue.main.addOperation { completion(self) }
      }
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
