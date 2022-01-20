//
//  DBStorageConfigurator.swift
//  SimplePhotoAlbum
//
//  Created by user on 17.01.2022.
//

import Foundation

open class DBStorageConfigurator {
    
    public static var storageType: DBStorage.Type?
    public static var storage: DBStorage? = DBStorageConfigurator.storageType?.init()
    
    public static func registerStorageClass(_ storageType: DBStorage.Type) {
        
        self.storageType = storageType
        storage = storageType.init()
    }
}
