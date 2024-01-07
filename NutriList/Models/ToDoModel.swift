//
//  ToDoModel.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import Foundation

struct ToDo: Decodable {
    let id: Int
    let createdAt: String
    let text: String
    let userUid: String
    let category: String
}

struct ToDoPayload: Codable {
    let text: String
    let userUid: String
    let category: String
    
    private enum CodingKeys: String, CodingKey {
        case text
        case userUid = "user_uid"
        case category
    }
}

