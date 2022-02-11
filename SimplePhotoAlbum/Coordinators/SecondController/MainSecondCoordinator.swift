//
//  MainSecondCoordinator.swift
//  SimplePhotoAlbum
//
//  Created by user on 10.02.2022.
//

import UIKit

final class MainSecondCoordinator: NSObject, Coordinator {
    
    private weak var flowListener: CoordinatorFlowListener?
    private let dependencies: CoordinatorDependencies
    private let navigationController: UINavigationController
    private var url: URL
    
    init(navigationController: UINavigationController,
         url: URL,
         coordinatorListener: CoordinatorFlowListener?,
         dependenciesManager: CoordinatorDependencies = DefaultCoordinatorDependencies()) {
        self.navigationController = navigationController
        dependencies = dependenciesManager
        self.url = url
        flowListener = coordinatorListener
        super.init()
    }
    
    func start() {
        let vc: DetailViewController = DetailWireFrame.create(model: url, router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func add(dependencies coordinator: Coordinator) {}
    
    func remove(dependencies coordinator: Coordinator) {}
}

extension MainSecondCoordinator: SecondViewControllerRoute {}

extension MainSecondCoordinator: SecondControllerDelegate {
    func didTabBack() {
        flowListener?.onFlowFinished(coordinator: self)
    }
}
