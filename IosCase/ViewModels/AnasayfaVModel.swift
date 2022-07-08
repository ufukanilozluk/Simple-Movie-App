//
//  CitiesMainVModel.swift
//  IosCase
//
//  Created by Ufuk Anıl Özlük on 30.11.2020.
//

import Alamofire
import Foundation
import UIKit

class AnasayfaVModel: MainVModel {
    var delegate: AnasayfaVModelDelegate?
    let selfView: UIView

    init(view: UIView) {
        selfView = view
    }

    func getUpcomingMovies(url: String) {
        var data: [Movie] = []

        startLoader(uiView: selfView)
        Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseJSON { response in

            switch response.result {
            case let .success(JSON):

                if let response = JSON as? [String: Any] {
                    if let response = response["results"] as? [[String: Any]] {
                        for el in response {
                            data.append(Movie(json: el))
                        }
                        self.delegate?.getUpcomingMoviesCompleted(data: data)
                    }

                } else {
                    print("Cast olamadı")
                }

            case let .failure(error):
                print(error.localizedDescription)
            }
            self.stopLoader(uiView: self.selfView)
        }
    }

    func getSliderPics(url: String) {
        var data: [Movie] = []

        startLoader(uiView: selfView)
        Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseJSON { response in

            switch response.result {
            case let .success(JSON):

                if let response = JSON as? [String: Any] {
                    if let response = response["results"] as? [[String: Any]] {
                        for el in response {
                            data.append(Movie(json: el))
                        }
                        self.delegate?.getSliderCompleted(data: data)
                    }

                } else {
                    print("Cast olamadı")
                }

            case let .failure(error):
                print(error.localizedDescription)
            }
            self.stopLoader(uiView: self.selfView)
        }
    }

    func getMovieById(url: String) {
        var data: Movie = Movie(json: [:])

        startLoader(uiView: selfView)
        Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseJSON { response in

            switch response.result {
            case let .success(JSON):

                if let response = JSON as? [String: Any] {
                    data = Movie(json: response)
                    self.delegate?.getMovieByIdCompleted(data: data)
                } else {
                    print("Cast olamadı")
                }

            case let .failure(error):
                print(error.localizedDescription)
            }
            self.stopLoader(uiView: self.selfView)
        }
    }
}
