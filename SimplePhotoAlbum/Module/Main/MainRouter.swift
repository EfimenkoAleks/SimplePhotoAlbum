//
//  MainRouter.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainRouter {
    weak var controller: UIViewController?
}

extension MainRouter: MainRouterProtocol {
    
    func routToDetail(model: String) {
        
        let view = DetailWireFrame.create(model: model)
        self.controller?.navigationController?.pushViewController(view, animated: true)
    }
}
