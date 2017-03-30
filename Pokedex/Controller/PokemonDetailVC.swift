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
  @IBOutlet weak var pokemonDescription: UILabel!
  @IBOutlet weak var pokemonDetailImage: UIImageView!

  var pokemon: Pokemon!

  override func viewDidLoad() {
    super.viewDidLoad()
    pokemonName.text = pokemon.name.capitalized
    pokemonDetailImage.image = UIImage(named: "\(pokemon.pokedexId)")
    pokemonDescription.text = "This is a Pokeman"
  }

  @IBAction func backButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
