//
//  Constants.swift
//  Pokedex
//
//  Created by Jake Romer on 4/1/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation

let API_VERSION = "2"
let URL_BASE = "http://pokeapi.co"
let URL_POKEMON = "/api/v\(API_VERSION)/pokemon"
let API_URL = "\(URL_BASE)/\(URL_POKEMON)"

typealias DownloadComplete = (Pokemon?) -> Void
