//
//  MainWireFrame.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainWireFrame {
    static func create() -> MainViewController {
        let view = MainViewController()
        let router = MainRouter()
        let viewModel = MainViewModel(router: router)
        router.controller = view
        view.viewModel = viewModel
        
        return view
    }
}
