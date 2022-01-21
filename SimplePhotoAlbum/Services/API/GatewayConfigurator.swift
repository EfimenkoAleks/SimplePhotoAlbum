//
//  GatewayConfigurator.swift
//  SimplePhotoAlbum
//
//  Created by user on 21.01.2022.
//

import Foundation

class GatewayConfigurator {
    
    private var defaultParametrs: [String: AnyObject] = [:]
    private var defaultHeaders: [String: String] = [:]
    
    func setHTTPHeader(value: String?, key: String) {
        defaultHeaders[key] = value
    }
}
