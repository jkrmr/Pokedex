//
//  HomeVC.swift
//  Pokedex
//
//  Created by Jake Romer on 3/28/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit
import AVFoundation

class HomeVC: UIViewController, UICollectionViewDelegate,
  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
  UISearchBarDelegate {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!

  var pokemons = [Pokemon]()
  var filteredPokemon = [Pokemon]()
  var inSearchMode = false
  var musicPlayer: AVAudioPlayer!

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.dataSource = self
    collectionView.delegate = self

    searchBar.delegate = self
    searchBar.returnKeyType = UIReturnKeyType.done

    let pokemonData = parsePokemonCSV()
    pokemons = Pokemon.create(collectionFrom: pokemonData)

    initAudio()
  }

  func initAudio() {
    do {
      let path = Bundle.main.path(forResource: "music", ofType: "mp3")
      musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
      musicPlayer.prepareToPlay()
      musicPlayer.numberOfLoops = -1
      //musicPlayer.play()
    } catch let error as NSError {
      print(error.debugDescription)
    }
  }

  func parsePokemonCSV() -> [Dictionary<String, String>] {
    do {
      guard let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        else { fatalError("could not find csv in bundle") }
      let csv = try CSV(contentsOfURL: path)
      let rows = csv.rows
      return rows
    } catch let error as NSError {
      print(error)
      return [] //[Dictionary<String, String>]()
    }
  }

  @IBAction func musicTogglePressed(_ sender: UIButton) {
    if musicPlayer.isPlaying {
      musicPlayer.stop()
      sender.alpha = 0.1
    } else {
      musicPlayer.play()
      sender.alpha = 1.0
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath)
    guard let pokeCell = cell as? PokeCell else { return cell }

    var pokemon: Pokemon

    if inSearchMode {
      pokemon = filteredPokemon[indexPath.row]
    } else {
      pokemon = pokemons[indexPath.row]
    }

    return pokeCell.configureCell(pokemon: pokemon)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var selectedPokemon: Pokemon

    if inSearchMode {
      selectedPokemon = filteredPokemon[indexPath.row]
    } else {
      selectedPokemon = pokemons[indexPath.row]
    }

    performSegue(withIdentifier: "PokemonDetailVC", sender: selectedPokemon)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PokemonDetailVC",
      let controller = segue.destination as? PokemonDetailVC,
      let pokemon = sender as? Pokemon {
      controller.pokemon = pokemon
      return
    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if inSearchMode {
      return filteredPokemon.count
    } else {
      return pokemons.count
    }
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 105, height: 105)
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    view.endEditing(true)
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text == nil || searchBar.text == "" {
      inSearchMode = false
      collectionView.reloadData()
    } else {
      inSearchMode = true
      let lower = searchText.lowercased()
      filteredPokemon = pokemons.filter { $0.name.lowercased().range(of: lower) != nil }
      collectionView.reloadData()
    }
  }
}
