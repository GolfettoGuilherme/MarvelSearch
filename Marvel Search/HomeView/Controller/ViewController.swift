//
//  ViewController.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var cvHeros: UICollectionView!
    
    var heros: Array<Hero> = []
    var detailController: HeroDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvHeros.dataSource = self
        cvHeros.delegate = self
        
        buscarHerois()
    }
    
    func buscarHerois() {
        MarvelApi().getHeroes { listaDeHerois in
            self.heros = listaDeHerois
            self.cvHeros.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo"{
            detailController = segue.destination as? HeroDetailViewController
        }
    }
    
}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        
        cell.setCell(hero: heros[indexPath.row])
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetHero = heros[indexPath.row]
        
        detailController.hero = targetHero
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 2 - 15, height: 160)
        
    }
    
}
