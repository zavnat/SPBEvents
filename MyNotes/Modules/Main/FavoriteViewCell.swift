//
//  FavoriteViewCell.swift
//  MyNotes
//
//  Created by admin on 17.08.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

protocol FavoriteCellDelegate: class {
  func likePressed(cell: UICollectionViewCell)
}

class FavoriteViewCell: UICollectionViewCell {
  
  weak var cellDelegate: FavoriteCellDelegate?
    
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var favorites: UIButton!
  
  @IBAction func favoritesButtonTapped(_ sender: UIButton) {
    cellDelegate?.likePressed(cell: self)
  }
}
