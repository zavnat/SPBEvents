//
//  Model.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation


// MARK: - Places
struct Places: Codable {
    let count: Int
    let next, previous: String
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title, slug, address, phone: String
    let siteURL: String
    let subway: String
    let isClosed: Bool
    let location: String
    let hasParkingLot: Bool

    enum CodingKeys: String, CodingKey {
        case id, title, slug, address, phone
        case siteURL = "site_url"
        case subway
        case isClosed = "is_closed"
        case location
        case hasParkingLot = "has_parking_lot"
    }
}

