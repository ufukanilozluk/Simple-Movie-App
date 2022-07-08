//
//  SehirlerVModelDelegate.swift
//  IosCase
//
//  Created by Ufuk Anıl Özlük on 25.11.2020.
//

import Foundation

protocol AnasayfaVModelDelegate{
    func getUpcomingMoviesCompleted(data:[Movie])
    func getSliderCompleted(data:[Movie])
    func getMovieByIdCompleted(data:Movie)
}
