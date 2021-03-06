//
//  PokeCell.swift
//  Pokedex
//
//  Created by Jake Romer on 3/28/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
  @IBOutlet weak var thumbImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!

  var pokemon: Pokemon!

  required init?(coder decoder: NSCoder) {
    super.init(coder: decoder)
    layer.cornerRadius = 5.0
  }

  func configureCell(pokemon: Pokemon) -> PokeCell {
    self.pokemon = pokemon
    thumbImage.image = UIImage(named: "\(pokemon.pokedexId)")
    nameLabel.text = pokemon.name.capitalized
    return self
  }
}
