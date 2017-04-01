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
  @IBOutlet weak var pokemonType: UILabel!
  @IBOutlet weak var pokemonDefense: UILabel!
  @IBOutlet weak var pokemonHeight: UILabel!
  @IBOutlet weak var pokemonWeight: UILabel!
  @IBOutlet weak var pokemonBaseAttack: UILabel!
  @IBOutlet weak var pokemonPokedexId: UILabel!

  var pokemon: Pokemon!

  override func viewDidLoad() {
    super.viewDidLoad()

    pokemonName.text = pokemon.name.capitalized
    pokemonDescription.text = pokemon.description
    pokemonType.text = pokemon.type
    pokemonDefense.text = "\(pokemon.defense)"
    pokemonHeight.text = "\(pokemon.height)"
    pokemonWeight.text = "\(pokemon.weight)"
    pokemonBaseAttack.text = "\(pokemon.baseAttack)"
    pokemonPokedexId.text = "\(pokemon.pokedexId)"
    pokemonDetailImage.image = UIImage(named: "\(pokemon.pokedexId)")
  }

  @IBAction func backButtonPressed(_ sender: Any) {
    dismiss(animated: true)
  }
}
