//
//  FirstCoordinator.swift
//  SimplePhotoAlbum
//
//  Created by user on 28.01.2022.
//

import UIKit

class FirstCoordinator: Coordinator {
  
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ item: UITabBarItem) {
        let vc: MainViewController = MainWireFrame.create()
        vc.firstCoordinator = self
        vc.tabBarItem = item
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetailController(url: URL?) {
        let vc: DetailViewController = DetailWireFrame.create(model: url)
  //      vc.firstCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
