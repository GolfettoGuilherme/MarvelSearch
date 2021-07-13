//
//  Hero.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit

class Hero: NSObject {
       
    init(thumbnail: String, name: String, heroDescription: String) {
        self.thumbnail = thumbnail
        self.name = name
        self.heroDescription = heroDescription
        self.comicList = []
        self.serieList = []
    }

    let thumbnail: String
    let name: String
    let heroDescription:String
    var comicList: [ComicSummary]
    var serieList: [SeriesSummary]
    
    func getURLforThumbnail() -> URL? {
        
        var urlFormatada = thumbnail
        
        if urlFormatada.hasPrefix("http://"){
            urlFormatada = urlFormatada.replacingOccurrences(of: "http:", with: "https:")
        }
        
        let url = URL(string: urlFormatada)
        return url
    }
}
