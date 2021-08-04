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
    
    func getHeroes(limit:Int = 60,offset: Int = 0, completion: @escaping (_ response: CharacterResponse) -> Void) {
        
        let limitRange = "&limit=\(limit)"
        
        let offsetRange = "&offset=\(offset)"
        
        AF.request(url + offsetRange + limitRange , method: .get).responseJSON { response in
        
            guard let dados = try? JSONDecoder().decode(CharacterResponse.self, from: response.data!) else { return }
            
            completion(dados)
            
        }
    }
    
}
