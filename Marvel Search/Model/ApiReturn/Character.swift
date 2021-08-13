//
//  Character.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 13/08/21.
//

import Foundation

struct Character:Codable {
    let name: String?
    let description: String?
    let thumbnail: Thumbnail?
    let comics: ComicList?
}
