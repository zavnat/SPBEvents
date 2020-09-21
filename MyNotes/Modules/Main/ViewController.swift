//
//  ViewController.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UICollectionViewController {
  
  var presenter: ViewToPresenterProtocol?
  var configurator: MainConfiguratorProtocol = MainConfigurator()
  var places = [ViewModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    configurator.configure(with: self)
    collectionView.refreshControl = presenter?.myRefreshControl
    presenter?.startFetchingPlaces()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(reactToNotification(_:)),
      name: .MainChanged,
      object: nil)
    addSourse()
  }
  
  @objc func reactToNotification(_ sender: Notification) {
    presenter?.notificationReceived()
  }
  
  func addSourse() {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    label.center = CGPoint(x: view.frame.width - (view.frame.width - 70), y: view.frame.height - 110)
    label.textAlignment = .center
    label.text = "kudago.com"
    label.textColor = .lightGray
    label.font = label.font.withSize(12)
    self.view.addSubview(label)
  }
  
  // MARK: - CollectionViewDataSourse Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return places.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PublishCollectionCell
    cell.configureCell(content: places[indexPath.row])
    cell.cellDelegate = self
    cell.label.text = places[indexPath.row].title.capitalized
    cell.image.kf.setImage(with: places[indexPath.row].image)
    
    if places[indexPath.row].favorite {
      cell.favorites.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
      cell.favorites.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    if places[indexPath.row].note != nil {
      cell.edit.isHidden = false
    } else {
      cell.edit.isHidden = true
    }
    return cell
  }
  
  
  //MARK: - CollectionViewDelegate Methods
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter?.cellSelected(places [indexPath.row].id)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let frameHeight = scrollView.frame.height
    presenter?.didScroll(offsrtY: offsetY, contentHeight: contentHeight, frameHeight: frameHeight)
  }
}

//MARK: - CollectionViewDelegateFlowLayout Methods
extension ViewController: UICollectionViewDelegateFlowLayout {
  
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

//MARK: - PresenterToViewProtocol Methods
extension ViewController: PresenterToViewProtocol {
  func showPlaces(placesArray: [ViewModel]) {
    self.places = placesArray

    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
  
  func showError() {
    print("Error fetching places")
  }
}

//MARK: - PublishCellDelegate Methods
extension ViewController: PublishCellDelegate {
  func likePressed(cell: UICollectionViewCell) {
    guard let indexPath = collectionView.indexPath(for: cell) else {return}
    let item = places[indexPath.row]
    let hasFavorite = item.favorite
    places[indexPath.row].favorite = !hasFavorite
    collectionView.reloadItems(at: [indexPath])
    
    presenter?.likedButtonTapped(with: item.id)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "goToDetail" else { return }
    guard let destination = segue.destination as? NoteViewController else { return }
    
    if let indexPath = collectionView.indexPathsForSelectedItems?.first {
      destination.id = places[indexPath.row].id
      destination.noteText = places[indexPath.row].note
      destination.favorite = places[indexPath.row].favorite
    }
  }
}


