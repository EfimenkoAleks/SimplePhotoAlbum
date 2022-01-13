//
//  SessionStorable.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

protocol SessionStorable {
    func getSession() -> Session?
    func saveSession(_ session: Session)
    func clear()
}
