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
    var searchCountItem: Int { get }
    func itemForCollection(index: Int) -> String
    func searchItemForCollection(index: Int) -> String
    func listPhoto() 
    func searchListPhoto()
    func goListPhoto()
    func filterContentForSearchText(_ searchText: String)
}

protocol MainViewModelProtocol: MainViewModelInputProtocol, MainViewModelOutputProtocol {}

protocol MainRouterProtocol: class {}

protocol MainViewModelDelegate: class {
    func didFetchingData()
}
