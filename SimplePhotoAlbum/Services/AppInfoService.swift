//
//  AppInfoService.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

class AppInfoService {
    
    private let appSettingsStorage: AppSettingsStorable
    var didChangeSettings: (() -> Void)?
    var didChangeCountryCode: (() -> Void)?
    var didChangeCurrencyCode: (() -> Void)?
    var didChangeLocaleCode: (() -> Void)?
    
    init(appSettingsStorage: AppSettingsStorable) {
        self.appSettingsStorage = appSettingsStorage
        
        //preloadAppSettingsData()
    }
}
