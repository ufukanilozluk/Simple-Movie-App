
import AlamofireImage
import ImageSlideshow
import Network
import UIKit

class AnasayfaVController: BaseVController {
    @IBOutlet var moviesTableView: UITableView!
    @IBOutlet var sliderImageView: ImageSlideshow!
    @IBOutlet var sliderTitleLabel: UILabel!
    @IBOutlet var sliderOverviewLabel: UILabel!

    let refreshControl = UIRefreshControl()

    var upcomingMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []
    var goToDetailSegue: String = "goToDetailSegue"

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

        fetchData()

        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
        refreshControl.attributedTitle = NSAttributedString(string: "Updating")
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        moviesTableView.addSubview(refreshControl)

        sliderImageView.currentPageChanged = { page in
            // do whatever you want eg:
            self.sliderOverviewLabel.text = self.upcomingMovies[page].overview
            self.sliderTitleLabel.text = self.upcomingMovies[page].original_title
        }

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        sliderImageView.addGestureRecognizer(gestureRecognizer)
    }

    @objc func didTap() {
        let index = sliderImageView.currentPage
        performSegue(withIdentifier: goToDetailSegue, sender: nowPlayingMovies[index].id)
    }

    @objc func didPullToRefresh() {
        fetchData()
    }

    func fetchData() {
        anasayfaVModel.getUpcomingMovies(url: URL.upcoming)
        anasayfaVModel.getSliderPics(url: URL.nowPlaying)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToDetailSegue {
            let destinationVC = segue.destination as! DetayVController
            destinationVC.id = sender as! Int
        }
    }
}

extension AnasayfaVController: AnasayfaVModelDelegate {
    func getMovieByIdCompleted(data: Movie) {}

    func getUpcomingMoviesCompleted(data: [Movie]) {
        upcomingMovies = data
        moviesTableView.reloadData()
        refreshControl.endRefreshing()
    }

    func getSliderCompleted(data: [Movie]) {
        if data.count > 0 {
            nowPlayingMovies = data
            let pictures = data.map({ $0.poster_path }) as! [String]
            var tmp: [String] = []
            for pic in pictures {
                tmp.append(URL.basePicUrl + pic)
            }
            addPics(tmp, on: sliderImageView)
            sliderOverviewLabel.text = data[0].overview
            sliderTitleLabel.text = data[0].original_title
        }
    }
}

extension AnasayfaVController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTVCell.reuseIdentifier, for: indexPath) as! MovieTVCell
        let rowData = upcomingMovies[indexPath.row]
        let tmp: [String] = [URL.basePicUrl + rowData.poster_path]

        addPics(tmp, on: cell.movieImageView)
        cell.titleLabel.text = rowData.original_title
        cell.overviewLabel.text = rowData.overview
        do {
            cell.releaseDateLabel.text = try? dateFormatter(to: .strToStr, value: rowData.release_date, outputFormat: "dd.MM.yy") as? String
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: goToDetailSegue, sender: upcomingMovies[indexPath.row].id)
    }
}
