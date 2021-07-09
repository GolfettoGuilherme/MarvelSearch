//
//  Hero.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit

class Hero: NSObject {
       
    init(thumbnail: String, name: String) {
        self.thumbnail = thumbnail
        self.name = name
    }

    let thumbnail:String
    let name:String
}
