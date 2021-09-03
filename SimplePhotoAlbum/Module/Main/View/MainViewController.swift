//
//  MainViewController.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
            guard let text = searchController.searchBar.text else { return false }
            return text.isEmpty
        }
    private var isFiltering: Bool {
            return searchController.isActive && !searchBarIsEmpty
        }
 
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            collection.registerCell(type: MainCollectionViewCell.self)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
 //           layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let width: CGFloat = (UIScreen.main.bounds.width / 2) - 1
            let aspectRatio: CGFloat = 0.75 //9 / 12
            let height = (width * aspectRatio) + 25
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = 2
            layout.minimumInteritemSpacing = 2
            
            collection.collectionViewLayout = layout
            collection.backgroundColor = .black
           
            collection.delegate = self
            collection.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createSearchController()
        self.viewModel.delegate = self
        self.view.backgroundColor = .systemPink
    }
    
    private func createSearchController() {
        // Setup the Seatch Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundColor = .black
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == self.viewModel.countItem - 5 {
           
            self.viewModel.searchListPhoto()
        }
//            self.photocollection?.scrollToItem(at: IndexPath(item: gIndexForCollection, section: 0), at: .top, animated: false)
//            gWillDisplay = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var model = ""
        if isFiltering {
            model = self.viewModel.searchItemForCollection(index: indexPath.item)
        } else {
            model = self.viewModel.itemForCollection(index: indexPath.item)
        }
        self.viewModel.routTodetail(model: model)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
           return self.viewModel.searchCountItem
        } else {
            return self.viewModel.countItem
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueCell(withType: MainCollectionViewCell.self, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        if isFiltering {
            let model = self.viewModel.searchItemForCollection(index: indexPath.item)
            //        cell.configur(model: model.urls?.small)
                    cell.configur(model: model)
            return cell
        } else {
            let model = self.viewModel.itemForCollection(index: indexPath.item)
            //        cell.configur(model: model.urls?.small)
                    cell.configur(model: model)
            return cell
        }
    }
}

extension MainViewController: MainViewModelDelegate {
    func didFetchingData() {
        self.collection.reloadData()
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.whiteColorText()
        self.viewModel.filterContentForSearchText(searchController.searchBar.text!)
    }
    
}

extension UISearchController {
    func whiteColorText() {
        self.searchBar.searchTextField.attributedText = NSAttributedString(string: searchBar.text!, attributes: [.foregroundColor: UIColor.white])
    }
}
