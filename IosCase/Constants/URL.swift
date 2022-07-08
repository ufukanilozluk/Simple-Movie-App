//
//  Colours.swift
//  IosCase
//
//  Created by Ufuk Anıl Özlük on 29.12.2020.
//

import Foundation
import UIKit

struct URL {
    // Sayıları 255 e böl rgb verirken
    static let apiKey = "?api_key=c5d89b35e37bb425f2170f2c646d5a3e"
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let upcoming = baseUrl + "upcoming" + apiKey
    static let nowPlaying = baseUrl + "now_playing" + apiKey
    static let basePicUrl = "https://image.tmdb.org/t/p/w780"
}

