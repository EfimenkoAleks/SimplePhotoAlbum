//
//  PhotoListSearchRequest.swift
//  SimplePhotoAlbum
//
//  Created by user on 02.02.2022.
//

import Foundation

public struct PhotoListSearchRequest {
    
    public struct PhotoListSearchResponseItem: Decodable {
        var total: Int?
        var totalPages: Int?
        var results: [ListPhotos]?
        
        enum CodingCase: String, CodingKey {
            case total = "total"
            case totalPages = "total_pages"
            case results = "results"
        }
    }
    
    public struct ListPhotos: Codable {
        
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
}

extension PhotoListSearchRequest: Request {
    var method: String {
        String(describing: self)
    }
    
    var params: [String : Any] {
        [:]
    }
}
