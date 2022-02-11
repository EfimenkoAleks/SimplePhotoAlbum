//
//  DetailWireFrame.swift
//  SimplePhotoAlbum
//
//  Created by user on 03.09.2021.
//

import UIKit

class DetailWireFrame {
    static func create(model: URL?, router: MainSecondCoordinator) -> DetailViewController {
        let view = DetailViewController(router: router)
        let viewModel = DetailViewModel(url: model)
        view.viewModel = viewModel
        
        return view
    }
}
