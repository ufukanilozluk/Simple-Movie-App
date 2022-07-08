
import AlamofireImage
import ImageSlideshow
import Network
import UIKit

class AnasayfaVController: BaseVController {

    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var sliderImageView: ImageSlideshow!
    
    var movies : [Movie] = []
    var goToDetailSegue : String = "goToDetailSegue"
    

    lazy var anasayfaVModel: AnasayfaVModel = {
        let vm = AnasayfaVModel(view: self.view)
        vm.delegate = self
        return vm
    }()

    override func viewDidLoad() {
        config()
    }
    
    func config() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        anasayfaVModel.getUpcomingMovies(url: URL.upcoming)
        anasayfaVModel.getSliderPics(url: URL.nowPlaying)
    }

  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToDetailSegue{
            let destinationVC = segue.destination as! DetayVController
            destinationVC.id = sender as! Int
        }
    }
}

extension AnasayfaVController: AnasayfaVModelDelegate {
    func getMovieByIdCompleted(data: Movie) {
        
    }
    
    func getUpcomingMoviesCompleted(data: [Movie]) {
        movies = data
        moviesTableView.reloadData()
    }
    
    func getSliderCompleted(data: [Movie]) {
        if data.count > 0 {
            let pictures = data.map({ $0.poster_path }) as! [String]
            var tmp : [String] = []
            for pic in pictures{
                tmp.append(URL.basePicUrl + pic)
            }
            addPics(tmp, on: sliderImageView)
        }
    }
}

extension AnasayfaVController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTVCell.reuseIdentifier, for: indexPath) as! MovieTVCell
        let rowData = movies[indexPath.row]
        let tmp : [String] = [URL.basePicUrl+rowData.poster_path]
        
        addPics(tmp, on: cell.movieImageView)
        cell.titleLabel.text = rowData.original_title
        cell.overviewLabel.text = rowData.overview
        do {
            // EEEE direk gün ismi
            cell.releaseDateLabel.text = try? dateFormatter(to: .strToStr, value: rowData.release_date, outputFormat: "dd.MM.yy") as? String
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: goToDetailSegue, sender: movies[indexPath.row].id)
    }
}



