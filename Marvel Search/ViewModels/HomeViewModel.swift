//
//  HomeViewModel.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 15/07/21.
//

import Foundation

struct HomeViewModel {
    
        
    func getHeroes(completion: @escaping (_ herois: [Character]) -> Void) {
        
        MarvelApi().getHeroes { response in
            completion(response.data.results ?? [])
        }
        
    }
    
    func getMoreHeroes(offset: Int, completion: @escaping (_ heroes: [Character]) -> Void) {
        
        MarvelApi().getHeroes(offset: offset) { response in
            completion(response.data.results ?? [])
        }
        
    }
    
    func getHero(by name: String, completion: @escaping(_ heroes: [Character]) -> Void){
        
        MarvelApi().getHero(by: name) { response in
            completion(response.data.results ?? [])
        }
        
    }
    
    
}
