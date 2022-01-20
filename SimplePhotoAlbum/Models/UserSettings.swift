//
//  UserSettings.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

struct UserSettings: Codable {
    var userOpenedPriceCount: Int
    var lastAppVersion: Int?
    
    static var defaultSettings: UserSettings {
        return .init(userOpenedPriceCount: 0, lastAppVersion: nil)
    }
}
