//
//  ViewController.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, PublishCellDelegate {
 
  var presenter: ViewToPresenterProtocol?
  var configurator: MainConfiguratorProtocol = MainConfigurator()
  
  var places = [ViewModel]()
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
   
    collectionView.delegate = self
    collectionView.dataSource = self
    
    print("view did load")
    configurator.configure(with: self)
    presenter?.startFetchingPlaces()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return places.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PublishCollectionCell
    cell.cellDelegate = self
    cell.label.text = places[indexPath.row].title
    cell.image.kf.setImage(with: places[indexPath.row].image)
//    cell.inputAccessoryView?.tintColor = places[indexPath.row].favorite ? UIColor.red : .lightGray
    if places[indexPath.row].favorite {
      cell.favorites.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }else {
      cell.favorites.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    return cell
  }


  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath)
    presenter?.cellSelected(places [indexPath.row].id)
    
  }
  
  
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
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let frameHeight = scrollView.frame.height
    presenter?.didScroll(offsrtY: offsetY, contentHeight: contentHeight, frameHeight: frameHeight)
  }
  
  func likePressed(cell: UICollectionViewCell) {
    let indexPath = collectionView.indexPath(for: cell)
    let item = places[indexPath!.row]
    
    let hasFavorite = item.favorite
    places[indexPath!.row].favorite = !hasFavorite
    collectionView.reloadItems(at: [indexPath!])
    print(item.favorite)
    print(item.title)
   }

}

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



