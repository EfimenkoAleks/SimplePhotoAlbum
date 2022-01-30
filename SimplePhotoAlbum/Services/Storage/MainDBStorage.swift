//
//  MainDBStorage.swift
//  SimplePhotoAlbum
//
//  Created by user on 27.01.2022.
//

import Foundation

class MainDBStorage: DBStorage {
    override func persistentStoreName() -> String? {
        return "DataModel"
    }
}
