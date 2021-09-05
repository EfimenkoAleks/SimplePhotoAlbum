//
//  ResultSearch.swift
//  SimplePhotoAlbum
//
//  Created by user on 02.09.2021.
//

import Foundation

struct ResultSearch: Codable {
    var total: Int?
    var totalPages: Int?
    var results: [ListPhotos]?
    
    enum CodingCase: String, CodingKey {
        case total = "total"
        case totalPages = "total_pages"
        case results = "results"
    }
}

struct OneResultSearch: Codable {
    var id: String?
    var width: Int
    var height: Int
    var urls: Urls?
}

struct Urls: Codable {
    let raw: URL?
    var full: URL?
    let regular: URL?
    var small: URL?
    let thumb: URL?
}
