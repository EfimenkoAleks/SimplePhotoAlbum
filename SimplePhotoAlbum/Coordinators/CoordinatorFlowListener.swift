//
//  CoordinatorFlowListener.swift
//  SimplePhotoAlbum
//
//  Created by user on 10.02.2022.
//

import Foundation

protocol CoordinatorFlowListener: class {
    func onFlowFinished(coordinator: Coordinator)
}
