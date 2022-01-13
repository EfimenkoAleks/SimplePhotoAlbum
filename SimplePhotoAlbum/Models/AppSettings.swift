//
//  AppSettings.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

struct AppSetings: Codable {
    
    var localeCode: String
    var countryCode: String
    var currencyCode: String
    
    static func createDefaultSettings () -> AppSetings {
        
        return AppSetings(
            localeCode: Locale.current.languageCode ?? "en",
            countryCode: Locale.current.regionCode ?? "US",
            currencyCode: Locale.current.currencyCode ?? "USD"
        )
    }
}
