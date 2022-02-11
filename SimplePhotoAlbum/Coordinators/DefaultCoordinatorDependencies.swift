//
//  DefaultCoordinatorDependencies.swift
//  SimplePhotoAlbum
//
//  Created by user on 10.02.2022.
//

import Foundation

final class DefaultCoordinatorDependencies: CoordinatorDependencies {
    private var dependencies = [Coordinator]()
    
    func add(dependency coordinator: Coordinator) {
        dependencies.append(coordinator)
    }
    
    func remove(dependency coordinator: Coordinator) {
        dependencies.removeLast()
    }
}
