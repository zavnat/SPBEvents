//
//  ViewController.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
 
  var presenter: ViewToPresenterProtocol?
  var configurator: MainConfiguratorProtocol = MainConfigurator()
  
  var places = [ViewModel]()
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
   
    collectionView.delegate = self
    collectionView.dataSource = self
    
    print("view did load")
    configurator.configure(with: self)
//    presenter?.load()
    presenter?.startFetchingPlaces()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return places.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PublishCollectionCell
    cell.label.text = places[indexPath.row].title
    cell.image.kf.setImage(with: places[indexPath.row].image)
    
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath)
//    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let navigationController = storyBoard.instantiateViewController(withIdentifier: "YourNavControllerIdentifier") as! UINavigationController
//
//    let viewController = storyBoard.instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
//    navigationController.pushViewController(viewController, animated: true)
//
//    self.present(navigationController, animated: true, completion: nil)
//   performSegue(withIdentifier: "goToDetail", sender: self)
//    performSegue(withIdentifier: "goToDetail", sender: self)
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
  
//  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    print("You tapped cell number \(indexPath.row).")
//    presenter?.cellSelected(places [indexPath.row].id)
////    performSegue(withIdentifier: "goToDetail", sender: self)
//  }
  
  
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



