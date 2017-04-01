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
    OperationQueue().addOperation {
      Alamofire.request(self.url).responseJSON { (resp) in
        guard let json = resp.result.value as? [String: AnyObject]
          else { return OperationQueue.main.addOperation { completion(nil) }}

        guard let baseAttack = json["attack"] as? Int,
          let defense = json["defense"] as? Int,
          let height = json["height"] as? String,
          let weight = json["weight"] as? String,
          let descriptions = json["descriptions"] as? [[String: String]],
          let description = descriptions.first,
          let descUrl = description["resource_uri"]
          else { return OperationQueue.main.addOperation { completion(nil) }}

        self.baseAttack = baseAttack
        self.defense = defense
        self.height = Int(height)
        self.weight = Int(weight)

        OperationQueue().addOperation {
          let urlString = "\(URL_BASE)\(descUrl)"
          Alamofire.request(urlString).responseJSON { (response) in
            guard let dict = response.result.value as? [String: AnyObject],
              let desc = dict["description"] as? String
              else { return OperationQueue.main.addOperation { completion(nil) }}
            self.description = desc
            OperationQueue.main.addOperation { completion(self) }
          }
        }
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
