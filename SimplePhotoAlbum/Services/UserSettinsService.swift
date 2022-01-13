//
//  UserSettinsService.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

class UserSettinsService: UserSettingsStorable
private let userSettingsStorage: UserSettingsStorable

var userSettings: UserSettings {
    get {
        userSettingsStorage.getUserSettings() ?? UserSettings.defaultSettings
    }
    set {
        userSettingsStorage.saveUserSettings(newValue)
    }
    
    var needShowHowItCalculated: Bool {
        return userSettings.userOpenedPriceCount <10
    }
    
    var appDidUpdate: Bool {
        return userSettings.lastAppVersion != Bundle.appVersion
    }
    
    init(userSettingsStorage: UserSettings = self.userSettings) {
        self.UserSettingsStorage = userSettingsStorage
    }
    
    
}
