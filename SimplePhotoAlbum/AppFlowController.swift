//
//  AppFlowController.swift
//  SimplePhotoAlbum
//
//  Created by user on 21.01.2022.
//

import Foundation
import UIKit

class AppFlowController {
    var tabBarItemTypes: [TabBarItemTypes] {
        return []
    }
    
    enum TabBarItemTypes: Int {
        case first
        case second
        
        var item: UITabBarItem {
            switch self {
            case .first:
                return UITabBarItem()
                
            case .second:
                return UITabBarItem()
            }
        }
    }
//    private var tabBar: 
}
