//
//  MainFirstCoordinator.swift
//  SimplePhotoAlbum
//
//  Created by user on 10.02.2022.
//

import UIKit

final class MainFirstCoordinator: NSObject, Coordinator {
    
    private let dependencies: CoordinatorDependencies
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController,
         dependenciesManager: CoordinatorDependencies = DefaultCoordinatorDependencies()) {
        self.navigationController = navigationController
        dependencies = dependenciesManager
        super.init()
    }
    
    func add(dependencies coordinator: Coordinator) {
        dependencies.add(dependency: coordinator)
    }
    
    func remove(dependencies coordinator: Coordinator) {
        dependencies.remove(dependency: coordinator)
    }
    
    func start() {
        let vc: MainViewController = MainWireFrame.create(router: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainFirstCoordinator: FirstViewControllerRoute {
    func showDetailController(url: URL) {
        
        guard let navigationControl = navigationController else { return }
        let secondCoord = MainSecondCoordinator(navigationController: navigationControl, url: url, coordinatorListener: self)
        secondCoord.start()
        add(dependencies: secondCoord)
    }
}

extension MainFirstCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        navigationController?.popViewController(animated: true)
        dependencies.remove(dependency: coordinator)
    }
}
