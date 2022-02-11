//
//  CoordinatorDependencies.swift
//  SimplePhotoAlbum
//
//  Created by user on 10.02.2022.
//

import Foundation

protocol CoordinatorDependencies {
    func add(dependency coordinator: Coordinator)
    func remove(dependency coordinator: Coordinator)
}
