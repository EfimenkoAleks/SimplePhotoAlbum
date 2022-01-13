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
    
    var user: User? {
   //     return User.objectByID(session?.userID)
        return User(name: "name")
    }
    
    var isAutenticatated: Bool {
        return user  != nil
    }
    
    func login(with session: Session) {
        sessionStorege.saveSession(session)
    }
    
    func becomeBuyer(buyer: Buyer) {
//        User.defaultStorage.saveAndWait { context in
//            user?.inContext(context)?.buyer = buyer.inContext(context)
//        }
        
    }
    
    func logout() {
        sessionStorege.clear()
    }
    
}

struct User {
    var name: String
}

struct Buyer {
    var user: String
}
