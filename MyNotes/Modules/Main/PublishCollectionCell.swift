//
//  Cell.swift
//  MyNotes
//
//  Created by admin on 23.07.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit


protocol PublishCellDelegate: class {
  func likePressed(cell: UICollectionViewCell)
}

class PublishCollectionCell: UICollectionViewCell {
  
  weak var cellDelegate: PublishCellDelegate?
  let gradientLayer = CAGradientLayer()
  @IBOutlet weak var favorites: UIButton!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var edit: UIButton!
  @IBOutlet weak var gradientView: UIView!
  var isGradient = false
  
  func configureCell(content: ViewModel) {
    if !isGradient {
      gradientView.fadeView()
      self.isGradient = true
    }
  }
  
  @IBAction func favoritesButtonTapped(_ sender: UIButton) {
    cellDelegate?.likePressed(cell: self)
  }
  
}
