//
//  MarvelApi.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import Foundation
import Alamofire


struct MarvelApi {

    let url = "https://gateway.marvel.com:443/v1/public/characters?limit=10&apikey=9a4fe82f93cdc43bc4ad46de0d20907a&ts=1625789388966&hash=ba58c2971f38720843c2ad54fd7844b0"
    
    func getHeroes(completion: @escaping (_ herois: Array<Hero>) -> Void) {
        
        AF.request(url, method: .get).responseJSON { response in
        
            guard let dados = try? JSONDecoder().decode(CharacterResponse.self, from: response.data!) else { return }
            
            completion(tratarRetorno(dados))
            
        }
    }
    
    func tratarRetorno(_ response: CharacterResponse) -> Array<Hero> {
        var herois:Array<Hero> = []
        
        guard let resultados = response.data.results else { return [] }
        
        for personagem in resultados {
            let name = personagem.name ?? ""
            guard let thumbData = personagem.thumbnail else { return []}
            let thumbPath = thumbData.path ?? ""
            let thumbExt = thumbData.ext ?? "jpg"
            let thumb =  thumbPath + "." + thumbExt
            
            herois.append(Hero(thumbnail: thumb, name: name))
        }
        
        return herois
    }
    
}

