//
//  FavoriteController.swift
//  MyNotes
//
//  Created by admin on 17.08.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteController: UICollectionViewController {
  
  var presenter: FavoriteViewToPresenterProtocol?
  var configurator: FavoriteConfiguratorProtocol = FavoriteConfigurator()
  var favoritePlaces = [FavoriteModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    configurator.configure(with: self)
    presenter?.startFetchingPlaces()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(reactToNotification(_:)),
      name: .FavoriteChanged,
      object: nil)
  }
  
  @objc func reactToNotification(_ sender: Notification) {
    print("Notification")
    presenter?.startFetchingPlaces()
  }
  
  
  //MARK: - CollectionViewDataSourse Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return favoritePlaces.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteViewCell
    cell.cellDelegate = self
    cell.label.text = favoritePlaces[indexPath.row].title.capitalized
    cell.image.kf.setImage(with: favoritePlaces[indexPath.row].image)
    if favoritePlaces[indexPath.row].favorite {
      cell.favorites.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
      cell.favorites.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    return cell
  }
  
}


// MARK: - CollectionViewDelegateFlowLayout Methods
extension FavoriteController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = collectionView.frame.height / 3
    let width  = collectionView.frame.width / 2 - 7
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1.5
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20.0
  }
}


//MARK: - FavoritePresenterToViewProtocol Methods
extension FavoriteController: FavoritePresenterToViewProtocol {
  func showPlaces(placesArray: [FavoriteModel]) {
    self.favoritePlaces = placesArray
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
  
  func showError() {
    print("Error fetching places")
  }
}


//MARK: - FavoriteCellDelegate Methods
extension FavoriteController: FavoriteCellDelegate {
  
  func likePressed(cell: UICollectionViewCell) {
    guard let indexPath = collectionView.indexPath(for: cell) else {return}
    let item = favoritePlaces[indexPath.row]
    favoritePlaces.remove(at: indexPath.row)
    collectionView.reloadData()
    
    presenter?.likedButtonTapped(with: item.id)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "favoriteDetail" else { return }
    guard let destination = segue.destination as? NoteViewController else { return }
    
    if let indexPath = collectionView.indexPathsForSelectedItems?.first {
      destination.id = favoritePlaces[indexPath.row].id
      destination.noteText = favoritePlaces[indexPath.row].note
      destination.favorite = favoritePlaces[indexPath.row].favorite
    }
  }
}



