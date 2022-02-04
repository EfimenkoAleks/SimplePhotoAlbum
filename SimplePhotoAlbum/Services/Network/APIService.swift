//
//  APIService.swift
//  SimplePhotoAlbum
//
//  Created by user on 02.09.2021.
//

import Foundation

protocol APIServiceDelegate: class {
    func tokenIsInvalid()
}

protocol APIService {
    func getListPhoto(photo:Int, completionHandler: @escaping (Result<[PhotoListRequest.PhotoListResponseItem], Error>) -> Void)
    func searchListPhoto(photo:Int, search: String, completionHandler: @escaping (Result<PhotoListSearchRequest.PhotoListSearchResponseItem, Error>) -> Void)
}
