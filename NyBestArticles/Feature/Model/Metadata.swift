import Foundation
struct Metadata: Decodable {
    let url: String = ""

    enum CodingKeys: String, CodingKey {
        case url
    }
}
