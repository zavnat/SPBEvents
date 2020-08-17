//
//  Cell.swift
//  MyNotes
//
//  Created by admin on 23.07.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit


protocol PublishCellDelegate {
  func likePressed(cell: UICollectionViewCell)
}

class PublishCollectionCell: UICollectionViewCell {
  
  var cellDelegate: PublishCellDelegate?
 
  @IBOutlet weak var favorites: UIButton!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var image: UIImageView!
  
  
  
  @IBAction func favoritesButtonTapped(_ sender: UIButton) {
    print("Button  Clicked")
    cellDelegate?.likePressed(cell: self)
  }
}
