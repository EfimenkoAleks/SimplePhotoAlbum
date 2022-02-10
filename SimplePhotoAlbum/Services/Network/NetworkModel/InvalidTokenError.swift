//
//  InvalidTokenError.swift
//  SimplePhotoAlbum
//
//  Created by user on 09.02.2022.
//

import Foundation

struct InvalidTokenError: Codable {
    let status: String
    let reason: String
    
    func isInvalidToken() -> Bool {
        return status == "failed"
    }
}

extension InvalidTokenError: Equatable {}
