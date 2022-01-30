//
//  DetailWireFrame.swift
//  SimplePhotoAlbum
//
//  Created by user on 03.09.2021.
//

import UIKit

class DetailWireFrame {
    static func create(model: URL?) -> DetailViewController {
        let view = DetailViewController()
        let viewModel = DetailViewModel(url: model)
        view.viewModel = viewModel
        
        return view
    }
}
