
import AlamofireImage
import ImageSlideshow
import Network
import UIKit

class AnasayfaVController: BaseVController {

    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var sliderImageView: ImageSlideshow!
    

    

    lazy var anasayfaVModel: AnasayfaVModel = {
        let vm = AnasayfaVModel(view: self.view)
        vm.delegate = self
        return vm
    }()

    override func viewDidLoad() {
        config()
    }
    
    func config() {
        anasayfaVModel.getUpcomingMovies(url: URL.upcoming)
        anasayfaVModel.getSliderPics(url: URL.nowPlaying)
    }

    func addPics(_ data: [String], on view: ImageSlideshow) {
        var alamofireSource: [AlamofireSource] = []
        for pic in data {
            alamofireSource.append(AlamofireSource(urlString: pic)!)
        }
        
        view.setImageInputs(alamofireSource)
        view.contentScaleMode = UIView.ContentMode.scaleToFill
    }
}

extension AnasayfaVController: AnasayfaVModelDelegate {
    func getCategoryCompleted(data: [Kategori]) {
        kategoriler = data
        kategoriCV.reloadData()
    }

    func getCoksatanCompleted(data: [CokSatan]) {
        cokSatanlar = data
        cokSatanlarCV.reloadData()
    }

    func getMarkalarCompleted(data: [Markalar]) {
        markalar = data
        markalarCV.reloadData()
    }

    func getSliderCompleted(data: [Slider]) {
        if data.count > 0 {
            let veri = data.map({ $0.picture }) as! [String]
            addPics(veri, on: ustSlide)
            addPics(veri, on: blogSlide)
        }
    }
}



