//
//  SehirlerVModelDelegate.swift
//  IosCase
//
//  Created by Ufuk Anıl Özlük on 25.11.2020.
//

import Foundation

protocol AnasayfaVModelDelegate: MainVModelDelegate {
    func getUpcomingMoviesCompleted(data:[Movie])
    func getSliderCompleted(data:[Movie])
}
