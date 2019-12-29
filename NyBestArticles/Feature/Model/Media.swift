import Foundation
import RealmSwift

class Media: Decodable {
    var caption: String? = ""
    var metadata: [Metadata] = [Metadata]()

    enum CodingKeys: String, CodingKey {
        case caption
        case metadata = "media-metadata"
    }
}
