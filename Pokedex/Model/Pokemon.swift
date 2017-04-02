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

        if let baseAttack = json["attack"] as? Int {
          self.baseAttack = baseAttack
          OperationQueue.main.addOperation { completion(self) }
        }

        if let defense = json["defense"] as? Int {
          self.defense = defense
          OperationQueue.main.addOperation { completion(self) }
        }

        if let height = json["height"] as? String {
          self.height = Int(height)
          OperationQueue.main.addOperation { completion(self) }
        }

        if let weight = json["weight"] as? String {
          self.weight = Int(weight)
          OperationQueue.main.addOperation { completion(self) }
        }

        if let types = json["types"] as? [[String: String]], types.count > 0 {
          let typeNames = types.flatMap({ $0["name"]?.capitalized })
          self.type = typeNames.joined(separator: " / ")
          OperationQueue.main.addOperation { completion(self) }
        }

        if let descriptions = json["descriptions"] as? [[String: String]],
          let description = descriptions.first,
          let descUrl = description["resource_uri"] {
          let urlString = "\(URL_BASE)\(descUrl)"

          Alamofire.request(urlString).responseJSON { (response) in
            guard let dict = response.result.value as? [String: AnyObject],
              let desc = dict["description"] as? String
              else { return }

            self.description =
              desc
                .replacingOccurrences(of: "POKMONS", with: "Pokemon's")
                .replacingOccurrences(of: "POKEMONS", with: "Pokemon's")
                .replacingOccurrences(of: "POKMON", with: "Pokemon")
                .replacingOccurrences(of: "POKEMON", with: "Pokemon")

            OperationQueue.main.addOperation { completion(self) }
          }
        }

        if let evolutions = json["evolutions"] as? [[String: AnyObject]] {
          let evo = evolutions.first
          self.evolutionName = evo?["to"] as? String

          let evoPath = evo?["resource_uri"] as? String
          let url = evoPath?.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
          self.evolutionID = url?.replacingOccurrences(of: "/", with: "")
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
