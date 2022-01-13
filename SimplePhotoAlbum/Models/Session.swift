//
//  Session.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

struct Session: Codable {
    let token: String
    let userID: Int
}

extension Session {
    init?(from dictionaty: [String: Any]) {
        guard let token: String = dictionaty["token"] as? String,
              let userDict = dictionaty["user"] as? [String: Any],
              let userID: Int = userDict["id"] as? Int else {
                  return nil
              }
        self.init(token: token, userID: userID)
    }
}
