//
//  DataModel.swift
//  MyNotes
//
//  Created by admin on 28.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation


// MARK: - Places
struct Places: Codable {
  let count: Int
  let next: String?
  let results: [Result]
}

// MARK: - Result
struct Result: Codable {
  let id: Int
  let title, slug: String
  let images: [Image]
}

// MARK: - Image
struct Image: Codable {
  let image: String
  
}

// MARK: - UIModel
struct ViewModel {
  let id: Int
  let title: String
  let image: URL?
  var favorite: Bool
  let note: String?
}

extension ViewModel {
  init(item: Note) {
    self.id = Int(item.id!)!
    self.title = item.title!
    self.image = URL(string: item.image!)
    self.favorite = item.favorite
    self.note = item.noteText
  }
}
