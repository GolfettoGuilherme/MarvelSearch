//
//  Thumbnail.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 13/08/21.
//

import Foundation

struct Thumbnail: Codable {
    
    let path: String?
    let ext: String?
    
    func getURLforThumbnail() -> URL? {
        
        if var urlFormatada = path {
            
            if urlFormatada.hasPrefix("http://"){
                
                urlFormatada = urlFormatada.replacingOccurrences(of: "http:", with: "https:")
                
                urlFormatada =  urlFormatada + "." + (ext ?? "jpg")
            }
            
            let url = URL(string: urlFormatada)
            
            return url
        }
        
        return nil
    }
    
}
