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
    func itemForCollection(index: Int) -> URL
    func itemForDidSelect(index: Int) -> URL?
    func neadLoadMore()
    func searchListPhoto(search: String)
    func routTodetail(model: URL?)
    func preload()
    func preloadSearch(search: String)
}

protocol MainViewModelProtocol: MainViewModelInputProtocol, MainViewModelOutputProtocol {}

protocol MainRouterProtocol: class {
    func routToDetail(model: URL?)
}

protocol MainViewModelDelegate: class {
    func didFetchingData()
}
