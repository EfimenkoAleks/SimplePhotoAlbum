//
//  AppFlowController.swift
//  SimplePhotoAlbum
//
//  Created by user on 21.01.2022.
//

import Foundation
import UIKit

class AppFlowController: UIViewController {
    
    var tabBarItemTypes: [TabBarItemType] {
        return []
    }
    
    enum TabBarItemType: Int {
        case first
        case second
        
        var item: UITabBarItem {
            switch self {
            case .first:
                return UITabBarItem(title: "colection", image: UIImage(systemName: "tray"), tag: self.rawValue)
                
            case .second:
                return UITabBarItem(title: "detail", image: UIImage(systemName: "book"), tag: self.rawValue)
            }
        }
    }
    
    var availableTabBarItemTypes: [TabBarItemType] {
        return [.first, .second]
    }
    private var embedTabBar: TabBar = TabBar()
    private var embedViewControllers: [TabBarItemType: UINavigationController] = [:]
    private var curentSelectedItemType: TabBarItemType?
    private var curentTabBarItem: UITabBarItem?
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    // MARK: Publik func
    
    func setSelectedTab() {
        embedTabBar.selectedItem = embedTabBar.items?.first
        updateSelectedViewController()
    }
    
}

// MARK: Private

fileprivate extension AppFlowController {
    
    private func initialSetup() {
        
        embedTabBar.delegate = self
        availableTabBarItemTypes.forEach({ embedViewControllers[$0] = childViewControllers(itemForVC: $0)})
        embedTabBar.tabAppearance = { [weak self] in
            self?.updateSelectedViewController()
        }
        embedTabBar.items = availableTabBarItemTypes.map { $0.item }
        embedTabBar.isTranslucent = false
        view.backgroundColor = .white
        view.addSubview(embedTabBar)
        embedTabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: embedTabBar.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: embedTabBar.trailingAnchor),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: embedTabBar.bottomAnchor)
        ])
        embedTabBar.selectedItem = embedTabBar.items?.first
        updateSelectedViewController()
    }
    
    
    // MARK: Child viewControllers
    
    func childViewControllers(itemForVC: TabBarItemType) -> UINavigationController {
        
        switch itemForVC {
        case .first:
            let vc: MainViewController = MainViewController()
            vc.tabBarItem = itemForVC.item
            let nav = UINavigationController.init(rootViewController: vc)
            return nav
        case .second:
            let vc: DetailViewController = DetailViewController()
            vc.tabBarItem = itemForVC.item
            let nav = UINavigationController.init(rootViewController: vc)
            return nav
        }
    }
    
    func updateSelectedViewController() {
        guard let item = embedTabBar.selectedItem,
              let itemType = TabBarItemType(rawValue: item.tag) else { return }
        if let item: TabBarItemType = curentSelectedItemType,
           let vc: UIViewController = embedViewControllers[item] {
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        if itemType == curentSelectedItemType,
           let selectedVC: UINavigationController = embedViewControllers[itemType],
           selectedVC.viewControllers.count > 1 {
            selectedVC.popViewController(animated: true)
        }
        curentSelectedItemType = itemType
        curentTabBarItem = embedTabBar.selectedItem
        if let selectedVC: UIViewController = embedViewControllers[itemType] {
            selectedVC.additionalSafeAreaInsets.bottom = embedTabBar.bounds.height
            addChild(selectedVC)
            selectedVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            selectedVC.view.frame = view.bounds
            view.addSubview(selectedVC.view)
            selectedVC.didMove(toParent: self)
        }
        view.bringSubviewToFront(embedTabBar)
    }
}

// MARK: UITabBarDelegate

extension AppFlowController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // here is the logic for selecting items
    }
}
