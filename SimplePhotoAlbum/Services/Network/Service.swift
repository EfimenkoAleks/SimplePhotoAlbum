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
    func reload(with hage: Int, params: [String: Any]?, completionHandler: @escaping (ServiceState) -> Void)
}
//
//extension Service {
//    func reload(with hage: Int, completionHandler: @escaping (ServiceState) -> Void) {}
//}
