//
//  DetailModel.swift
//  MyNotes
//
//  Created by admin on 29.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

// MARK: - Empty
struct PlaceDetail: Codable {
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
    let images: [Image]
    let commentsCount: Int
    let isClosed: Bool
    let categories: [String]
    let shortTitle: String
    let tags: [String]
    let location: String
    let ageRestriction: Int
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
        case ageRestriction = "age_restriction"
        case disableComments = "disable_comments"
        case hasParkingLot = "has_parking_lot"
    }
}

// MARK: - Coords
struct Coords: Codable {
    let lat, lon: Double
}

// MARK: - Image
struct Image: Codable {
    let image: String
    let source: Source
}

// MARK: - Source
struct Source: Codable {
    let name: String
    let link: String
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        // No-op
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
