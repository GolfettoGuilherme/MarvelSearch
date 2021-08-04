//
//  ViewController.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var cvHeros: UICollectionView!
    
    var heroes: Array<Hero> = []
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvHeros.dataSource = self
        cvHeros.delegate = self
        
        viewModel.getHeroes { listHeroes in
            self.heroes = listHeroes
            self.cvHeros.reloadData()
        }
    }
   
}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        
        cell.setCell(hero: heroes[indexPath.row])
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetHero = heroes[indexPath.row]
        
        let controller = HeroDetailViewController()

        controller.hero = targetHero
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == heroes.count / 2 {
            
            viewModel.getMoreHeroes(offset: heroes.count) { listHeroes in
                self.heroes.append(contentsOf: listHeroes)
                self.cvHeros.reloadData()
            }
            
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 2 - 15, height: 200)
        
    }
    
}
