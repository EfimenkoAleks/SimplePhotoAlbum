//
//  AppSettingsStorage.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

class AppSettingsStorage: AppSettingsStorable {
    
    private let storage: Storable
    
    private let kAppSettingsStoreKey: String = "kAppSettingsStoreKey"
    
    init(storage: Storable) {
        self.storage = storage
    }
    
    func getAppSettings() -> AppSetings? {
        return storage.value(forKey: kAppSettingsStoreKey)
    }
    
    func saveAppSettings(_ appSettings: AppSetings) {
        storage.set(appSettings, forKey: kAppSettingsStoreKey)
    }
    
    func clearAppSettings() {
        storage.clearValue(forKey: kAppSettingsStoreKey)
    }
}
