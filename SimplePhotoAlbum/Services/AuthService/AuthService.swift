//
//  AuthService.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

class AuthService {
    
    private let sessionStorege: SessionStorable
    
    init(sessionStorage: SessionStorable) {
        self.sessionStorege = sessionStorage
    }
    
    var session: Session? {
        return sessionStorege.getSession()
    }
    
    var user: SUser? {
        return SUser.objectByID(session?.userID)
        
    }
    
    var isAutenticatated: Bool {
        return user  != nil
    }
    
    func login(with session: Session) {
        sessionStorege.saveSession(session)
    }
    
    func logout() {
        sessionStorege.clear()
    }
    
}
