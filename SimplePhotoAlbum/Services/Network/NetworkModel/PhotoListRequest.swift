//
//  PhotoListRequest.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.02.2022.
//

import Foundation

public struct PhotoListRequest {
    
    public struct PhotoListResponseItem: Decodable {
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

extension PhotoListRequest: Request {
    var method: String {
        String(describing: self)
    }
    
    var params: [String : Any] {
        [:]
    }
}
