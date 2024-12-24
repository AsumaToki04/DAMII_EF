//
//  Models.swift
//  DAMII_EF
//
//  Created by DAMII on 23/12/24.
//

import Foundation

struct Photo: Codable {
    let results: [Result]
}

struct Result: Codable, Identifiable {
    let id: String
    let description: String?
    let user: User
    let urls: Url
}

struct User: Codable {
    let name: String
    let instagram_username: String?
}

struct Url: Codable {
    let full: String
    let thumb: String?
}
