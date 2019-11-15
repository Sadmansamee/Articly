import Foundation

class Media: Decodable {
    let caption: String?
    let metadata: [Metadata]?

    enum CodingKeys: String, CodingKey {
        case caption
        case metadata = "media-metadata"
    }
}
