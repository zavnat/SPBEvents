//
//  FavoriteViewCell.swift
//  MyNotes
//
//  Created by admin on 17.08.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

protocol FavoriteCellDelegate {
  func likePressed(cell: UICollectionViewCell)
//  func notePressed(cell: UICollectionViewCell)
}

class FavoriteViewCell: UICollectionViewCell {
  
  var cellDelegate: FavoriteCellDelegate?
    
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var favorites: UIButton!
  
  @IBAction func favoritesButtonTapped(_ sender: UIButton) {
    cellDelegate?.likePressed(cell: self)
  }
//  @IBAction func noteButtonPressed(_ sender: UIButton) {
//    cellDelegate?.notePressed(cell: self)
//  }
}
