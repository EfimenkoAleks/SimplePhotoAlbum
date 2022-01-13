//
//  AppSettingsStorable.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

protocol AppSettingsStorable {
    func getAppSettings() -> AppSetings?
    func saveAppSettings(_ appSettings: AppSetings)
    func clearAppSettings()
}
