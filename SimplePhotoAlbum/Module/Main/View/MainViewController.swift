//
//  MainViewController.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol!
    
//    private let searchController = UISearchController(searchResultsController: nil)
//    private var searchBarIsEmpty: Bool {
//            guard let text = searchController.searchBar.text else { return false }
//            return text.isEmpty
//        }
//    private var isFiltering: Bool {
//            return searchController.isActive && !searchBarIsEmpty
//        }
    
    private var isFiltering: Bool = false
    private var textFild: UITextField?
 
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
            collection.prefetchDataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

 //       self.createSearchController()
        self.viewModel.delegate = self
        self.view.backgroundColor = .systemPink
    }
    
    override func viewWillLayoutSubviews() {
        createSearchController()
    }
    
    private func createSearchController() {
        
        let viewContent = UIView()
        viewContent.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.3)
        viewContent.layer.cornerRadius = 5
        viewContent.layer.masksToBounds = true
        guard let navBar = self.navigationController?.navigationBar else { return }
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        navBar.addSubview(viewContent)
        NSLayoutConstraint.activate([
            viewContent.centerXAnchor.constraint(equalTo: navBar.centerXAnchor),
            viewContent.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -5),
            viewContent.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            viewContent.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -30),
            viewContent.heightAnchor.constraint(equalToConstant: 40)
        ])
        textFild = UITextField()
        textFild?.font = UIFont.systemFont(ofSize: 22)
        textFild?.backgroundColor = .clear
        textFild?.translatesAutoresizingMaskIntoConstraints = false
        guard let textF = textFild else { return }
        viewContent.addSubview(textF)
        NSLayoutConstraint.activate([
            textF.centerYAnchor.constraint(equalTo: viewContent.centerYAnchor),
            textF.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor,constant: 8),
            textF.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -100),
            textF.heightAnchor.constraint(equalToConstant: 40)
        ])
        let buttonSearch = UIButton()
        buttonSearch.layer.cornerRadius = 5
        buttonSearch.layer.masksToBounds = true
        buttonSearch.setTitle("Search", for: .normal)
        buttonSearch.setTitleColor(UIColor.black, for: .normal)
        buttonSearch.addTarget(self, action: #selector(MainViewController.searchAction), for: .touchUpInside)
        buttonSearch.backgroundColor = .clear
        buttonSearch.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(buttonSearch)
        NSLayoutConstraint.activate([
            buttonSearch.centerYAnchor.constraint(equalTo: viewContent.centerYAnchor),
            buttonSearch.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor),
            buttonSearch.heightAnchor.constraint(equalToConstant: 40),
            buttonSearch.widthAnchor.constraint(equalToConstant: 60)
        ])
        let buttonDelete = UIButton()
        buttonDelete.layer.cornerRadius = 10
        buttonDelete.layer.masksToBounds = true
        let image = UIImage(systemName: "delete.left")?.withRenderingMode(.alwaysTemplate)
        buttonDelete.setBackgroundImage(image, for: .normal)
        buttonDelete.tintColor = .black
        buttonDelete.addTarget(self, action: #selector(MainViewController.deleteAction), for: .touchUpInside)
        buttonDelete.backgroundColor = .clear
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(buttonDelete)
        NSLayoutConstraint.activate([
            buttonDelete.centerYAnchor.constraint(equalTo: viewContent.centerYAnchor),
            buttonDelete.trailingAnchor.constraint(equalTo: buttonSearch.leadingAnchor),
            buttonDelete.heightAnchor.constraint(equalToConstant: 40),
            buttonDelete.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func deleteAction() {
        self.textFild?.text = ""
        self.isFiltering = false
        self.viewModel.preload()
    }
    
    @objc func searchAction() {
     //   self.viewModel.reloadDataSource()
        self.isFiltering = true
        self.viewModel.preloadSearch(search: self.textFild?.text ?? "")
 //       self.viewModel.searchListPhoto(search: self.textFild?.text ?? "")
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if isFiltering {
            if indexPath.item == self.viewModel.countItem - 15 {
                self.viewModel.searchListPhoto(search: self.textFild?.text ?? "")
        }
        } else {
            if indexPath.item == self.viewModel.countItem - 15 {
                self.viewModel.listPhoto()
        }
        }
        
//            self.photocollection?.scrollToItem(at: IndexPath(item: gIndexForCollection, section: 0), at: .top, animated: false)
//            gWillDisplay = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let model = self.viewModel.itemForDidSelect(index: indexPath.item)
            self.viewModel.routTodetail(model: model)
    
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.viewModel.countItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueCell(withType: MainCollectionViewCell.self, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
            let model = self.viewModel.itemForCollection(index: indexPath.item)
        cell.configur(model: model.image)
            return cell
    }
}

extension MainViewController: MainViewModelDelegate {
    func didFetchingData() {
        self.collection.reloadData()
    }
}

//extension MainViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        searchController.whiteColorText()
//        self.collection.reloadData()
//        self.viewModel.filterContentForSearchText(searchController.searchBar.text!)
//    }
//
//}

//extension UISearchController {
//    func whiteColorText() {
//        self.searchBar.searchTextField.attributedText = NSAttributedString(string: searchBar.text!, attributes: [.foregroundColor: UIColor.white])
//    }
//}

extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            print("\(indexPath.item)")
//            self.viewModel.loadPhoto(index: indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
     // Cancel any requests for data for the specified index paths.
//     for indexPath in indexPaths {
//     let model = models[indexPath.row]
//     yourfetchClass.cancelFetch(model.id)
//     }
    }
    
    
}
