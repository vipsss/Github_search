//
//  Repository.swift
//  Github_search
//
//  Created by Mac User on 14.02.2023.
//

import Foundation

struct RepositoryResponce: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    
    struct Owner: Codable {
        let html_url: String
    }
    
    let id: Int
    let name: String
    let html_url: String
    let owner: Owner
}
