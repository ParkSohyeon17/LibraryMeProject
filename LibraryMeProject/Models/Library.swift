//
//  Library.swift
//  LibraryMeProject
//
//  Created by 박소현 on 2023/10/18.
//

import Foundation

struct Library: Codable {
    
    let code: String
    let data: LibraryData
    let success: Bool
    let message: String
}

// MARK: - LibraryData
struct LibraryData: Codable {
    let offset, totalCount: Int
    let list: [LibraryItem]
    let max: Int
    let isFuzzy: Bool
    let facets: [Facet]
}

// MARK: - LibraryItem
struct LibraryItem: Codable {
    let etcContent: String
    let titleStatement: String
    let thumbnailURL: String?
    let issn, isbn: String?
    let id: Int
    let author: String
    let publication: String
    let similars: [Similar]

    enum CodingKeys: String, CodingKey {
        case etcContent, titleStatement
        case thumbnailURL = "thumbnailUrl"
        case issn, id, author, isbn, publication, similars
    }
    
    // MARK: - Similar
    struct Similar: Codable {
        let id: Int
        let titleStatement, publication: String
    }
}

// MARK: - Facet
struct Facet: Codable {
    let size: Int
    let name, code: String
    let items: [FacetItem]
}

// MARK: - FacetItem
struct FacetItem: Codable {
    let count: Int
    let label, value: String
}
