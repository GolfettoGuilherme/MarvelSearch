//
//  HomeViewModel.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 15/07/21.
//

import Foundation

struct HomeViewModel {
    
    let imagemNotAvailable = "image_not_available"
    
    func getHeroes(completion: @escaping (_ herois: Array<Hero>) -> Void) {
        
        MarvelApi().getHeroes { response in
            completion(generateHeroes(from: response))
        }
        
    }
    
    private func generateHeroes(from response: CharacterResponse) -> Array<Hero> {
        var listHeroes:Array<Hero> = []
        
        guard let result = response.data.results else { return [] }
        
        for character in result {
            
            let name = character.name ?? ""
            guard let thumbData = character.thumbnail else { continue }

            let thumbPath = thumbData.path ?? ""
            
            if thumbPath.contains(imagemNotAvailable) {
                continue
            }
            
            let thumbExt = thumbData.ext ?? "jpg"
            
            let thumb =  thumbPath + "." + thumbExt
            
            let heroDescription = character.description ?? ""
            
            let hero = Hero(thumbnail: thumb, name: name, heroDescription: heroDescription)
            
            if let comicList = character.comics, let comicSumarry = comicList.items {
                for comic in comicSumarry {
                    hero.comicList.append(comic)
                }
            }
            
            if let serieList = character.series, let serieSumarry = serieList.items {
                for serie in serieSumarry {
                    hero.serieList.append(serie)
                }
            }
            
            listHeroes.append(hero)
        }
        
        return listHeroes
    }
}
