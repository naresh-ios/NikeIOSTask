import Foundation
import UIKit

struct RSSFeedDataObject: Codable {
    var feed: Feed
    enum CodingKeys: String, CodingKey {
        case feed = "feed"
    }
}

struct Feed: Codable {
    var title, id, copyright, country, icon, updated : String
    var author: Author
    var results: [Result]
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case id = "id"
        case copyright = "copyright"
        case country = "country"
        case icon = "icon"
        case updated = "updated"
        case author = "author"
        case results = "results"
    }
}

struct Author: Codable {
    var name, uri: String
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case uri = "uri"
    }
}

struct Result: Codable {
    var artistName, id, releaseDate, name, kind, copyright, artistId, artistUrl, artworkUrl100, url: String
    var genres: [Genre]
    enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case id = "id"
        case releaseDate = "releaseDate"
        case name = "name"
        case kind = "kind"
        case copyright = "copyright"
        case artistId = "artistId"
        case artistUrl = "artistUrl"
        case artworkUrl100 = "artworkUrl100"
        case url = "url"
        case genres = "genres"
    }
}

struct Genre: Codable {
    var genreId, name, url: String
    enum CodingKeys: String, CodingKey {
        case genreId = "genreId"
        case name = "name"
        case url = "url"
    }
}
