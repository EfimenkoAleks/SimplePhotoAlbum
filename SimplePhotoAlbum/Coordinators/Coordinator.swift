//
//  Coordinator.swift
//  SimplePhotoAlbum
//
//  Created by user on 28.01.2022.
//

import UIKit

protocol Coordinator {
//    var cildCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start(_ item: UITabBarItem)
}
