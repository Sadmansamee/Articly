import Foundation
import RealmSwift

class Article: Object, Decodable {
    @objc dynamic var url: String = ""
    @objc dynamic var section: String = ""
    @objc dynamic var byline: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var abstract: String = ""
    @objc dynamic var publishedDate: Date = Date()
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var source: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var views: Int = 0
    @objc dynamic var largeImage: String = ""
    @objc dynamic var smallImage: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case url
        case section
        case byline
        case title
        case abstract
        case publishedDate = "published_date"
        case createdAt
        case source
        case id
        case views
        case media
    }

    required init() {
        super.init()
    }

    convenience init(url: String, section: String,
                     byline: String, title: String, abstract: String,
                     publishedDate: Date, source: String, id: Int, views: Int,
                     largeImage: String, smallImage: String) {
        self.init()
        self.url = url
        self.section = section
        self.byline = byline
        self.title = title
        self.abstract = abstract
        self.publishedDate = publishedDate
        self.source = source
        self.id = id
        self.views = views
        self.largeImage = largeImage
        self.smallImage = smallImage
    }

    required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let url = try values.decode(String.self, forKey: .url)
        let section = try values.decode(String.self, forKey: .section)
        let byline = try values.decode(String.self, forKey: .byline)
        let title = try values.decode(String.self, forKey: .title)
        let abstract = try values.decode(String.self, forKey: .abstract)
        let publishedDate = try values.decode(String.self, forKey: .publishedDate)
            .toDate(withFormat: KEnum.TimeFormat.date.rawValue)
        let source = try values.decode(String.self, forKey: .source)
        let id = try values.decode(Int.self, forKey: .id)
        let views = try values.decode(Int.self, forKey: .views)

        let media = try values.decodeIfPresent([Media].self, forKey: .media)

        var largeImage: String = ""
        var smallImage: String = ""
        if let firstMedia = media?.first,
            let firstMeta = firstMedia.metadata.first,
            let lastMeta = firstMedia.metadata.last {
            smallImage = firstMeta.url
            largeImage = lastMeta.url
        }

        self.init(url: url, section: section, byline: byline, title: title,
                  abstract: abstract, publishedDate: publishedDate,
                  source: source, id: id, views: views,
                  largeImage: largeImage, smallImage: smallImage)
    }
}
