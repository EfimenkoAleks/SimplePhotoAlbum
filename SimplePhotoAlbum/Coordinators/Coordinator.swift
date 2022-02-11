//
//  Coordinator.swift
//  SimplePhotoAlbum
//
//  Created by user on 28.01.2022.
//

import UIKit

protocol Coordinator {
    
    func add(dependencies coordinator: Coordinator)
    func remove(dependencies coordinator: Coordinator)
    func start()
}
