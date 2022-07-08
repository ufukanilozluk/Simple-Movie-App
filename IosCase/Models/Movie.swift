
import Foundation

struct Movie: Codable {
    var id : Int
    var original_title: String
    var overview: String
    var release_date: String
    var poster_path: String
    var vote_average: Double
    var vote_count: Int

    init(json: [String: Any]) {
        id = json["id"] as? Int ?? 0
        original_title = json["original_title"] as? String ?? ""
        overview = json["overview"] as? String ?? ""
        release_date = json["release_date"] as? String ?? ""
        poster_path = json["poster_path"] as? String ?? ""
        vote_average = json["vote_average"] as? Double ?? 0.0
        vote_count = json["vote_count"] as? Int ?? 0
       
    }
}
