//
//  MarvelApi.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import Foundation
import Alamofire


struct MarvelApi {

    let url = "https://gateway.marvel.com:443/v1/public/characters?limit=20&apikey=9a4fe82f93cdc43bc4ad46de0d20907a&ts=1625789388966&hash=ba58c2971f38720843c2ad54fd7844b0"
    
    func getHeroes(completion: @escaping (_ herois: Array<Hero>) -> Void) {
        
        AF.request(url + generateGenericsOffsets() , method: .get).responseJSON { response in
        
            guard let dados = try? JSONDecoder().decode(CharacterResponse.self, from: response.data!) else { return }
            
            completion(tratarRetorno(dados))
            
        }
    }
    
    func generateGenericsOffsets() -> String {
        let offset = Int.random(in: 10..<1453)
        
        return "&offset=\(offset)"
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
            
            let heroDescription = personagem.description ?? ""
            
            let hero = Hero(thumbnail: thumb, name: name, heroDescription: heroDescription)
            
            if let comicList = personagem.comics {
                if let comicSumarry = comicList.items {
                    for comic in comicSumarry {
                        hero.comicList.append(comic)
                    }
                }
            }
            
            if let serieList = personagem.series {
                if let serieSumarry = serieList.items {
                    for serie in serieSumarry {
                        hero.serieList.append(serie)
                    }
                }
            }
            
            herois.append(hero)
        }
        
        return herois
    }
    
    
    
}

