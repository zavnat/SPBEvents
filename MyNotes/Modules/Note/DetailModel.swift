//
//  DetailModel.swift
//  MyNotes
//
//  Created by admin on 29.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

// MARK: - DetailModel
struct DetailModel: Codable {
  let id, publicationDate: Int
  let dates: [DatesArray]
  let title, slug: String
  let purpleDescription, bodyText: String
  let categories: [String]
  let tagline: String
  let price: String
  let isFree: Bool
  let images: [ImageItem]
  let favoritesCount, commentsCount: Int
  let siteURL: String
  let shortTitle: String
  let tags: [String]
  let disableComments: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case publicationDate = "publication_date"
    case dates, title, slug
    case purpleDescription = "description"
    case bodyText = "body_text"
    case categories, tagline
    case price
    case isFree = "is_free"
    case images
    case favoritesCount = "favorites_count"
    case commentsCount = "comments_count"
    case siteURL = "site_url"
    case shortTitle = "short_title"
    case tags
    case disableComments = "disable_comments"
  }
}

// MARK: - Image
struct ImageItem: Codable {
  let image: String
}

// MARK: - DateElement
struct DatesArray: Codable {
  let start, end: Int
}


// MARK: - DetailUIModel
struct DetailUIModel {
  let title: String
  let image: URL?
  //  var favorite: Bool
  let bodyText: String
  let startDate: String
  let endDate: String
}

extension DetailUIModel {
  init(from item: DetailModel, startDate: String, endDate: String) {
    title = item.title
    image = URL(string: item.images[0].image)
    self.startDate = startDate
    self.endDate = endDate
    //    favorite = false
    bodyText = item.bodyText
  }
}

