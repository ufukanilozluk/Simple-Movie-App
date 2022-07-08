//
//  KampanyalarVController.swift
//  IosCase
//
//  Created by Ufuk Anıl Özlük on 17.05.2022.
//

import UIKit
import ImageSlideshow

class DetayVController: BaseVController {

    @IBOutlet weak var movieThumbnailImageView: ImageSlideshow!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var movieDetailTextView: UITextView!
    var id : Int = 0
    
    lazy var anasayfaVModel: AnasayfaVModel = {
        let vm = AnasayfaVModel(view: self.view)
        vm.delegate = self
        return vm
    }()

    override func viewDidLoad() {
        config()
    }
    
    func config() {

        anasayfaVModel.getMovieById(url: URL.baseUrl + String(id) + URL.apiKey)
    }

     
   

}

extension DetayVController: AnasayfaVModelDelegate {
    func getMovieByIdCompleted(data: Movie) {
        
        rateLabel.text = String(data.vote_average) + "/10"
        dateLabel.text = try? dateFormatter(to: .strToStr, value: data.release_date, outputFormat: "dd.MM.yy") as? String
        movieDetailTextView.text = data.overview
        addPics( [URL.basePicUrl + data.poster_path], on: movieThumbnailImageView)
        
    }
    
    func getSliderCompleted(data: [Movie]) {
        
    }
    
    func getUpcomingMoviesCompleted(data: [Movie]) {
        
    }
    
}
