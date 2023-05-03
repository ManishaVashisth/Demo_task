//
//  TableDetails.swift
//  DemoProject
//
//  Created by Manisha Vashisth on 01/05/23.
//

import Foundation

// MARK: - WelcomeElement
struct TableData: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

//var tableData: [TableData] = []
class TableDataManger {
    static let shared = TableDataManger()
    init() {
    }
    var tableData: [TableData] = []
}
