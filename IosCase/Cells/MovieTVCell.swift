//
//  AnasayfaDailyWeatherCVCell.swift
//  IosCase
//
//  Created by Ufuk Anıl Özlük on 18.12.2020.
//

import UIKit
import ImageSlideshow

class MovieTVCell: UITableViewCell {
    @IBOutlet weak var movieImageView: ImageSlideshow!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseIdentifier = "MoviesCell"
    
}
