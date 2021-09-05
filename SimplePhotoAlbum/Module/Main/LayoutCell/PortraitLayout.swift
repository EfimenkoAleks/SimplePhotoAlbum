//
//  PortraitLayout.swift
//  SimplePhotoAlbum
//
//  Created by user on 05.09.2021.
//

import UIKit

class PortraitLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .vertical
        
        let width: CGFloat = (UIScreen.main.bounds.width / 2) - 1
        let aspectRatio: CGFloat = 0.75 
        let height = (width * aspectRatio) + 25
        
        self.itemSize = CGSize(width: width, height: height)
        self.minimumLineSpacing = 2.0
        self.minimumInteritemSpacing = 2.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        guard let collectionView = collectionView,
              collectionView.numberOfSections != 0 else { return }
    }
}
