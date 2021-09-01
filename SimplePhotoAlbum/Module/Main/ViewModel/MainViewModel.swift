//
//  MainViewModel.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import Foundation

class MainViewModel {
    private var router: MainRouterProtocol
    weak var delegate: MainViewModelDelegate?
    private var photos: [Data]
    
    init(router: MainRouterProtocol) {
        self.router = router
        self.photos = []
    }
}

extension MainViewModel: MainViewModelProtocol {
    var countItem: Int {
        return self.photos.count
    }
    
    func itemForCollection(index: Int) -> Data {
        return self.photos[index]
    }
}
