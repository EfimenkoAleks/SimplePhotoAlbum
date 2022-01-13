//
//  Storable.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation

protocol Storable {
    func value<Value: Codable>(forKey key: String) -> Value?
    func set<Value: Codable>(_ value: Value, forKey key: String)
    func clearValue(forKey key: String)
}
