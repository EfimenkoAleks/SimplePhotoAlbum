//
//  AppInfoService.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

extension NSNotification.Name {
    static let kDidChangeAppSettings: NSNotification.Name = .init("kDidChangeAppSettings")
}

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
    
    private(set) var settings: AppSetings {
        get {
            appSettingsStorage.getAppSettings() ?? AppSetings.createDefaultSettings()
        }
        set {
            appSettingsStorage.saveAppSettings(newValue)
            NotificationCenter.default.post(name: .kDidChangeAppSettings, object: nil)
            didChangeSettings?()
        }
    }
}
