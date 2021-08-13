//
//  Something.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 13/08/21.
//

import Foundation

struct DataResponse:Codable {
    let total: Int
    let count: Int
    let results: [Character]?
}
