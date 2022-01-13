//
//  SessionStorage.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

class SessionStorage: SessionStorable {
    private let storage: Storable
    private let kSessionStoreKey: String = "kSessionStoreKey"
    
    init(storage: Storable) {
        self.storage = storage
    }
    
    func getSession() -> Session? {
        return storage.value(forKey: kSessionStoreKey)
    }
    
    func saveSession(_ session: Session) {
        storage.set(session, forKey: kSessionStoreKey)
    }
    
    func clear() {
        storage.clearValue(forKey: kSessionStoreKey)
    }
}
