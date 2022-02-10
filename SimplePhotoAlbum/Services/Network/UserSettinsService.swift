//
//  UserSettinsService.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

class UserSettinsService {
private let _userSettingsStorage: UserSettingsStorable

var userSettings: UserSettings {
    get {
        _userSettingsStorage.getUserSettings() ?? UserSettings.defaultSettings
    }
    set {
        _userSettingsStorage.saveUserSettings(newValue)
    }
}
    
    var needShowHowItCalculated: Bool {
        return userSettings.userOpenedPriceCount < 10
    }
    
    var appDidUpdate: Bool {
        return userSettings.lastAppVersion != Bundle.version()
    }
    
    init(userSettingsStorage: UserSettingsStorable) {
        _userSettingsStorage = userSettingsStorage
    }
    
    func userDidOpenPrice() {
        var userSettingsNew: UserSettings = userSettings
        userSettingsNew.userOpenedPriceCount += 1
        userSettings = userSettingsNew
    }
}
