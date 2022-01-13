//
//  UserSettingsStorable.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

protocol UserSettingsStorable {
    func getUserSettings() -> UserSettings?
    func saveUserSettings(_ appSettings: UserSettings)
    func clearUserSettings()
}
