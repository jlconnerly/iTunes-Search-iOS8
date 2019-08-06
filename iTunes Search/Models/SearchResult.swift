//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Jake Connerly on 8/6/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    var results: [SearchResult]
}

struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case album = "collectionName"
        case image = "artworkUrl100"
    }
    
    var title: String
    var creator: String
    var album: String?
    var image: URL
}
