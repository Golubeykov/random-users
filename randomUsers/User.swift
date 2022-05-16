//
//  User.swift
//  randomUsers
//
//  Created by Антон Голубейков on 16.05.2022.
//

import Foundation

// Структура для парсинга пользователя из JSON

struct User: Decodable, Identifiable {
    let id: String
    let name: Name
    
    var fullName: String {
        name.title + "." + name.first + " " + name.last
    }
    
    init(from decoder: Decoder) throws {
        // собираем name из JSON (лежит в root)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        // вытаскиваем uuid из вложенного контейнера login
        let loginInfo = try values.nestedContainer(keyedBy: LoginInfoCodingKeys.self, forKey: .login)
        id = try loginInfo.decode(String.self, forKey: .uuid)
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case name
    }
    
    enum LoginInfoCodingKeys: String, CodingKey {
        case uuid
    }
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}

// Здесь сохраняем массив пользователей после парсинга JSON
struct Response: Decodable {
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}
