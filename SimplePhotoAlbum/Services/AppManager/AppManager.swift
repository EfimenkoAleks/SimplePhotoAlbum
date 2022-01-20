//
//  AppManager.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

class AppManager {
    
    static let shared: AppManager = AppManager()
    
    let authService: AuthService = AuthService(sessionStorage: SessionStorage(storage: Storage()))
    let appInfoService: AppInfoService = AppInfoService(appSettingsStorage: AppSettingsStorage(storage: Storage()))
    let userSettingsService: UserSettins = UserSettings()
    var preferedLanguage: [String] {
        return [appInfoService.settings.localeCode]
    }
    
}
