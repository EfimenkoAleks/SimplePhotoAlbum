//
//  MainInterfaces.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import Foundation

protocol MainViewModelInputProtocol: class {}

protocol MainViewModelOutputProtocol: class {
    var delegate: MainViewModelDelegate? { set get }
    var countItem: Int { get }
    func itemForCollection(index: Int) -> Data
}

protocol MainViewModelProtocol: MainViewModelInputProtocol, MainViewModelOutputProtocol {}

protocol MainRouterProtocol: class {}

protocol MainViewModelDelegate: class {
    func didFetchingData()
}
