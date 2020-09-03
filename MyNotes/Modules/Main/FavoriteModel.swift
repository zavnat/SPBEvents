//
//  FavoriteModel.swift
//  MyNotes
//
//  Created by admin on 01.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

// MARK: - UIFavoriteModel
struct FavoriteModel {
  let id: Int
  let title: String
  let image: URL?
  var favorite: Bool
  let note: String?
}

extension FavoriteModel {
  init(item: Liked) {
    self.id = Int(item.id!)!
    self.title = item.title!
    self.image = URL(string: item.image!)
    self.favorite = item.favorite
    self.note = item.noteText
  }
}
