//
//  DetailInterfaces.swift
//  SimplePhotoAlbum
//
//  Created by user on 03.09.2021.
//

import Foundation

protocol DetailViewModelInputProtocol: class {}

protocol DetailViewModelOutputProtocol: class {
    var delegate: DetailViewModelDelegate? { get set }
    func downloadPhoto()
}

protocol DetailViewModelProtocol: DetailViewModelInputProtocol, DetailViewModelOutputProtocol {}

protocol DetailRouterProtocol {}

protocol DetailViewModelDelegate: class {
    func didDownloadPhoto(image: String)
}
