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

struct Image: Codable {
  let image: String
  
}
