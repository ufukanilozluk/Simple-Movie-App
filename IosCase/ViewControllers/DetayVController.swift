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
    @IBOutlet weak var movieTitleLabel: UILabel!
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
        //To remove default textview padding
        movieDetailTextView.textContainer.lineFragmentPadding = 0.0
        anasayfaVModel.getMovieById(url: URL.baseUrl + String(id) + URL.apiKey)
        
    }

}

extension DetayVController: AnasayfaVModelDelegate {
    func getMovieByIdCompleted(data: Movie) {
        
        rateLabel.text = String(data.vote_average)
        dateLabel.text = try? dateFormatter(to: .strToStr, value: data.release_date, outputFormat: "dd.MM.yy") as? String
        movieDetailTextView.text = data.overview
        addPics( [URL.basePicUrl + data.poster_path], on: movieThumbnailImageView)
        movieTitleLabel.text = data.original_title
        navigationItem.title = data.original_title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SF Pro Text Bold", size: 15)!]
    }
    
    func getSliderCompleted(data: [Movie]) {}
    func getUpcomingMoviesCompleted(data: [Movie]) {}
}
