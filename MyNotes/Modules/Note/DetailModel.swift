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
  let id: Int
  let title, slug, address, timetable: String
  let phone: String
  let isStub: Bool
  let bodyText, purpleDescription: String
  let siteURL: String
  let foreignURL: String
  let coords: Coords
  let subway: String
  let favoritesCount: Int
  let images: [ImageItem]
  let commentsCount: Int
  let isClosed: Bool
  let categories: [String]
  let shortTitle: String
  let tags: [String]
  let location: String
  let disableComments, hasParkingLot: Bool
  
  enum CodingKeys: String, CodingKey {
    case id, title, slug, address, timetable, phone
    case isStub = "is_stub"
    case bodyText = "body_text"
    case purpleDescription = "description"
    case siteURL = "site_url"
    case foreignURL = "foreign_url"
    case coords, subway
    case favoritesCount = "favorites_count"
    case images
    case commentsCount = "comments_count"
    case isClosed = "is_closed"
    case categories
    case shortTitle = "short_title"
    case tags, location
    case disableComments = "disable_comments"
    case hasParkingLot = "has_parking_lot"
  }
}

// MARK: - Coords
struct Coords: Codable {
  let lat, lon: Double
}

// MARK: - Image
struct ImageItem: Codable {
  let image: String
}
