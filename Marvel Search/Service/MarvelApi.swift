//
//  MarvelApi.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import Foundation
import Alamofire


struct MarvelApi {

    
    private let url = "https://gateway.marvel.com:443/v1/public/characters?apikey=9a4fe82f93cdc43bc4ad46de0d20907a&ts=1625789388966&hash=ba58c2971f38720843c2ad54fd7844b0"
    
    func getHeroes(completion: @escaping (_ response: CharacterResponse) -> Void) {
        
        let limit = "&limit=\(30)"
        
        let randomOffsets = "&offset=\(Int.random(in: 10..<1453))"
        
        AF.request(url + randomOffsets + limit , method: .get).responseJSON { response in
        
            guard let dados = try? JSONDecoder().decode(CharacterResponse.self, from: response.data!) else { return }
            
            completion(dados)
            
        }
    }
    
}


