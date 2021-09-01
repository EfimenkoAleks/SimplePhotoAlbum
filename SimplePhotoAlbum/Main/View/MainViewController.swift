//
//  MainViewController.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol!
 
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            collection.registerCell(type: MainCollectionViewCell.self)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
 //           layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let width: CGFloat = (UIScreen.main.bounds.width / 2) - 5
            let aspectRatio: CGFloat = 0.75 //9 / 12
            let height = (width * aspectRatio) + 25
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
            
            collection.collectionViewLayout = layout
            collection.backgroundColor = .black
           
            collection.delegate = self
            collection.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.delegate = self
        self.view.backgroundColor = .systemRed
    }

}

extension MainViewController: UICollectionViewDelegate {}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.countItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueCell(withType: MainCollectionViewCell.self, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        let model = self.viewModel.itemForCollection(index: indexPath.item)
        cell.configur(model: model)
        return cell
    }
}

extension MainViewController: MainViewModelDelegate {
    func didFetchingData() {
        self.collection.reloadData()
    }
}
