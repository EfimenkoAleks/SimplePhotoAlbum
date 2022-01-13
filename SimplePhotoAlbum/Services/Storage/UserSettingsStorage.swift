//
//  UserSettingsStorage.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

class UserSettingsStorage: UserSettingsStorable {
    private let storage: Storable
    
    private let kUserSettingsStoreKey: String = "kUserSettingsStoreKey"
    
    init(storage: Storable) {
        self.storage = storage
    }
    
    func getUserSettings() -> UserSettings? {
        return storage.value(forKey: kUserSettingsStoreKey)
    }
    
    func saveUserSettings(_ appSettings: UserSettings) {
        storage.set(appSettings, forKey: kUserSettingsStoreKey)
    }
    
    func clearUserSettings() {
        storage.clearValue(forKey: kUserSettingsStoreKey)
    }
}
