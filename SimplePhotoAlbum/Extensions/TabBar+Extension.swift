//
//  TabBar+Extension.swift
//  SimplePhotoAlbum
//
//  Created by user on 26.01.2022.
//

import UIKit

class TabBar: UITabBar {
    var tabAppearance: (() -> Void)?
    
    override var frame: CGRect {
        didSet {
            if frame != .zero {
                tabAppearance?()
            }
        }
    }
}
