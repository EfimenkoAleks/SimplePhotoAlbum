//
//  MainViewController.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol!
    
    private var isFiltering: Bool = false
    private var textFild: UITextField?
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            collection.registerCell(type: MainCollectionViewCell.self)
            let layout = PortraitLayout()
            collection.collectionViewLayout = layout
            collection.backgroundColor = .black
            
            collection.delegate = self
            collection.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.delegate = self
        self.view.backgroundColor = .black
        createSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        coordinator.animate(alongsideTransition: { [unowned self] _ in
            if newCollection.verticalSizeClass == .compact {
                collection.collectionViewLayout = LandscapeLayout()
                
            } else {
                collection.collectionViewLayout = PortraitLayout()
                
            }
        }) { [unowned self] _ in
            collection.collectionViewLayout.invalidateLayout()
            collection.layoutIfNeeded()
        }
    }
    
    private func createSearchController() {
        
        let viewContent = UIView()
        viewContent.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5)
        viewContent.layer.cornerRadius = 5
        viewContent.layer.masksToBounds = true
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(viewContent)
        NSLayoutConstraint.activate([
            viewContent.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            viewContent.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            viewContent.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
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
            textF.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor,constant: 16),
            textF.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -116),
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
            buttonSearch.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            buttonSearch.heightAnchor.constraint(equalToConstant: 40),
            buttonSearch.widthAnchor.constraint(equalToConstant: 60)
        ])
        let buttonDelete = UIButton()
        buttonDelete.layer.cornerRadius = 10
        buttonDelete.layer.masksToBounds = true
       
        let scaleConfig = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "clear", withConfiguration: scaleConfig)?.withRenderingMode(.alwaysTemplate)
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
        self.isFiltering = true
        self.viewModel.preloadSearch(search: self.textFild?.text ?? "")
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
