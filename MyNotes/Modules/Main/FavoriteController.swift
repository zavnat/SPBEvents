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
  var places = [FavoriteModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    configurator.configure(with: self)
    presenter?.startFetchingPlaces()
    NotificationCenter.default.addObserver(self, selector: #selector(reactToNotification(_:)), name: .FavoriteChanged, object: nil)
//    collectionView.refreshControl = presenter?.myRefreshControl
  }
  
  @objc func reactToNotification(_ sender: Notification) {
    print("Notification")
    presenter?.startFetchingPlaces()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("will appear")
  }
  
  //MARK: - CollectionViewDataSourse Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return places.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteViewCell
    cell.cellDelegate = self
    cell.label.text = places[indexPath.row].title.capitalized
    cell.image.kf.setImage(with: places[indexPath.row].image)
    if places[indexPath.row].favorite {
      cell.favorites.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
      cell.favorites.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    return cell
  }
  
  
  //MARK: - CollectionViewDelegate Methods
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    presenter?.cellSelected(places [indexPath.row].id)
  }
  
//  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    let offsetY = scrollView.contentOffset.y
//    let contentHeight = scrollView.contentSize.height
//    let frameHeight = scrollView.frame.height
////    presenter?.didScroll(offsrtY: offsetY, contentHeight: contentHeight, frameHeight: frameHeight)
//  }
}

//MARK: - CollectionViewDelegateFlowLayout Methods
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

////MARK: - PresenterToViewProtocol Methods
extension FavoriteController: FavoritePresenterToViewProtocol {
  func showPlaces(placesArray: [FavoriteModel]) {
    self.places = placesArray
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }

  func showError() {
    print("Error fetching places")
  }
}
//
//MARK: - PublishCellDelegate Methods
extension FavoriteController: FavoriteCellDelegate {
  
  func likePressed(cell: UICollectionViewCell) {
    print("like pressed")
    guard let indexPath = collectionView.indexPath(for: cell) else {return}
    let item = places[indexPath.row]
    let hasFavorite = item.favorite
    places[indexPath.row].favorite = !hasFavorite
    collectionView.reloadItems(at: [indexPath])
    print(item.favorite)
    print(item.title)
//
    presenter?.likedButtonTapped(with: item.id)
  }
  
  func notePressed(cell: UICollectionViewCell) {
    var textField = UITextField()
          
          let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
          
          let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
              
              // What will happen when the user click the Add Item button on our UIAlert
              do{
    //              if let currentCategory = self.selectedCategory {
    //                  try self.realm.write {
    //                      let newItem = Item()
    //                      newItem.title = textField.text!
    //                      newItem.dateCreated = Date()
    //                      currentCategory.items.append(newItem)
    //                  }
    //              }
                  
              }catch {
                  print("Error  saving new item \(error)")
              }
              
    //          self.tableView.reloadData()
              
          }
          
          
          alert.addTextField { (alertTextField) in
              alertTextField.placeholder = "Create new item"
              textField = alertTextField
          }
          
          alert.addAction(action)
          present(alert, animated: true, completion: nil)
  }
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    print("Prepare")
//    guard segue.identifier == "goToDetail" else { return }
//    guard let destination = segue.destination as? NoteViewController else { return }
//
//    if let indexPath = collectionView.indexPathsForSelectedItems?.first {
//      destination.id = places[indexPath.row].id
//    }
//  }
}



