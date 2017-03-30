//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Jake Romer on 3/29/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
  @IBOutlet weak var pokemonName: UILabel!
  var pokemon: Pokemon!

  override func viewDidLoad() {
    super.viewDidLoad()
    pokemonName.text = pokemon.name
  }
}
