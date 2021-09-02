//
//  ListPhotos.swift
//  SimplePhotoAlbum
//
//  Created by user on 02.09.2021.
//

import Foundation

//struct ListPhotos: Codable {
//    var array: [Photo]
//}

struct ListPhotos: Codable {
    
    var id: String?
    let width: Int
    let height: Int
    var urls: URLImage?
}

struct URLImage: Codable {
    let raw: URL?
    var full: URL?
    let regular: URL?
    var small: URL?
    let thumb: URL?
}
