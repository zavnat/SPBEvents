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
  
  var places = [Result]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    let width = view.frame.size.width / 2
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    print("view did load")
    configurator.configure(with: self)
    presenter?.startFetchingPlaces()
  }
  
  @IBAction func addButtonPressed(_ sender: Any) {

  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return places.count
    }
    
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PublishCollectionCell
    cell.label.text = places[indexPath.row].title
      let imageString = places[indexPath.row].images[0].image
      let url = URL(string: imageString)
    cell.layer.cornerRadius = 10
      cell.image.kf.setImage(with: url)
      
      return cell
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

//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 1.5
//        }
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return 1.5
//        }
}

extension ViewController: PresenterToViewProtocol {
  func showPlaces(placesArray: [Result]) {
    self.places = placesArray
    collectionView.reloadData()
    

    
  }
  
  func showError() {
    print("Error fetching places")
  }
}




// MARK: - UITableViewDelegate, UITableViewDataSource
//extension ViewController {
//
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return places.count
//  }
//
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//    cell.textLabel?.text = places[indexPath.row].title
//
//
//    return cell
//  }
//
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let indexPath = tableView.indexPathForSelectedRow {
//      let itemForDetail = places[indexPath.row]
//      presenter?.router?.prepare(for: segue, data: itemForDetail)
//    }
//
//  }
//
//}

