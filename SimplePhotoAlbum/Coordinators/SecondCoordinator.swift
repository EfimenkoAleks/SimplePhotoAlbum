//
//  SecondCoordinator.swift
//  SimplePhotoAlbum
//
//  Created by user on 30.01.2022.
//

import UIKit

class SecondCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ item: UITabBarItem) {
        let url: URL = URL(string: "https://images.unsplash.com/photo-1643266809211-8c65ed4a92c8?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNTc4ODF8MHwxfGFsbHwyNXx8fHx8fHx8MTY0MzI5MTk0OQ&ixlib=rb-1.2.1&q=85")!
        let vc: DetailViewController = DetailWireFrame.create(model: url)
        vc.secondCoordinator = self
        vc.tabBarItem = item
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
