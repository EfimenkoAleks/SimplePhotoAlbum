//
//  MainWireFrame.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainWireFrame {
    static func create(router: FirstViewControllerRoute) -> MainViewController {
        
        let view = MainViewController(router: router)
        let viewModel = MainViewModel()
        view.viewModel = viewModel
        
        return view
    }
}
