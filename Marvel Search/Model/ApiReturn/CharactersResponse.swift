//
//  CharacterResponse.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import Foundation

struct CharactersResponse: Codable {
    let code: Int
    let status: String
    let data: DataResponse
}
