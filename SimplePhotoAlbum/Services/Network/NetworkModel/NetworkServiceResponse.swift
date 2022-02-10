//
//  NetworkServiceResponse.swift
//  SimplePhotoAlbum
//
//  Created by user on 09.02.2022.
//

import Foundation

struct NetworkServiceResponse {
    let data: Data?
    let error: Error?
    let headers: [AnyHashable: Any]
}
