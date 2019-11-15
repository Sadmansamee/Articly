import Foundation
import RealmSwift

class Metadata: Decodable {
    var url: String = ""

    enum CodingKeys: String, CodingKey {
        case url
    }
}
