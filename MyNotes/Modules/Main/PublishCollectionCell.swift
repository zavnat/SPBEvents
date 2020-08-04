//
//  Cell.swift
//  MyNotes
//
//  Created by admin on 23.07.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class PublishCollectionCell: UICollectionViewCell {
 
  @IBOutlet weak var favorites: UIButton!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var image: UIImageView!
  
  
  
  @IBAction func favoritesButtonTapped(_ sender: UIButton) {
    print("Button  Clicked")
//    favorites.setImage(UIImage(systemName: "heart.fill"), for: .normal)
  }
}
