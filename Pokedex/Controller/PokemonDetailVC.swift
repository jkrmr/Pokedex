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
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

  var pokemon: Pokemon!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.loadingIndicator.startAnimating()
    pokemon.downloadDetails { (pokemon) in
      guard let pokemon = pokemon else { return }
      self.updateUI(pokemon)
    }
  }

  func updateUI(_ pokemon: Pokemon) {
    pokemonName.text = pokemon.name.capitalized
    pokemonPokedexId.text = "\(pokemon.pokedexId)"
    pokemonDetailImage.image = UIImage(named: "\(pokemon.pokedexId)")

    if let defense = pokemon.defense { pokemonDefense.text = "\(defense)" }
    if let height = pokemon.height { pokemonHeight.text = "\(height)" }
    if let weight = pokemon.weight { pokemonWeight.text = "\(weight)" }
    if let baseAttack = pokemon.baseAttack { pokemonBaseAttack.text = "\(baseAttack)" }

    pokemonType.text = pokemon.type
    pokemonDescription.text = pokemon.description
    self.loadingIndicator.stopAnimating()
  }

  @IBAction func backButtonPressed(_ sender: Any) {
    dismiss(animated: true)
  }
}
