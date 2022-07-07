
import AlamofireImage
import ImageSlideshow
import Network
import UIKit

class AnasayfaVController: BaseVController {

    
    var kategoriler: [Kategori] = []
    var cokSatanlar: [CokSatan] = []
    var markalar: [Markalar] = []
    var animationContainerView: UIView!

//    lazy var anasayfaVModel: AnasayfaVModel = {
//        let vm = AnasayfaVModel(view: self.view)
//        vm.delegate = self
//        return vm
//    }()

    override func viewDidLoad() {
//        config()
    }
    
//    func config() {
//
//        anasayfaVModel.getCategories(url: "https://mocki.io/v1/87f0826f-cef4-4fd3-9968-1358a68ca2da")
//        anasayfaVModel.getCokSatan(url: "https://mocki.io/v1/87f0826f-cef4-4fd3-9968-1358a68ca2da")
//        
//    }

    func addPics(_ data: [String], on view: ImageSlideshow) {
        var alamofireSource: [AlamofireSource] = []
        for pic in data {
            alamofireSource.append(AlamofireSource(urlString: pic)!)
        }
        
        view.setImageInputs(alamofireSource)
        view.contentScaleMode = UIView.ContentMode.scaleToFill
    }
}

//extension AnasayfaVController: AnasayfaVModelDelegate {
//    func getCategoryCompleted(data: [Kategori]) {
//        kategoriler = data
//        kategoriCV.reloadData()
//    }
//
//    func getCoksatanCompleted(data: [CokSatan]) {
//        cokSatanlar = data
//        cokSatanlarCV.reloadData()
//    }
//
//    func getMarkalarCompleted(data: [Markalar]) {
//        markalar = data
//        markalarCV.reloadData()
//    }
//
//    func getSliderCompleted(data: [Slider]) {
//        if data.count > 0 {
//            let veri = data.map({ $0.picture }) as! [String]
//            addPics(veri, on: ustSlide)
//            addPics(veri, on: blogSlide)
//        }
//    }
//}



