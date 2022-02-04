//
//  Service.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.02.2022.
//

import Foundation

enum ServiceState {
    case initial
    case loading
    case loaded
    case error
}

protocol Service: AnyObject {
    var state: ServiceState { get }
    func reload(completionHandler: @escaping (ServiceState) -> Void)
}
