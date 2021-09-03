//
//  DetailWireFrame.swift
//  SimplePhotoAlbum
//
//  Created by user on 03.09.2021.
//

import UIKit

class DetailWireFrame {
    static func create(model: String) -> UIViewController {
        let view = DetailViewController()
        let router = DetailRouter()
        let viewModel = DetailViewModel(router: router, url: model)
        view.viewModel = viewModel
        router.controller = view
        
        return view
    }
}
