//
//  APIService.swift
//  SimplePhotoAlbum
//
//  Created by user on 02.09.2021.
//

import Foundation

protocol APIService {
    func getListPhoto(photo:Int, completionHandler: @escaping (Result<[ListPhotos]>) -> Void)
    func searchListPhoto(photo:Int, search: String, completionHandler: @escaping (Result<ResultSearch>) -> Void)
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum APIError: Error {
    case noData
}

