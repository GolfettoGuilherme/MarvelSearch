//
//  ViewController.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var cvHeros: UICollectionView!

    let searchController = UISearchController(searchResultsController: nil)
    var isSearching = false
    
    var heroes: [Character]?
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvHeros.dataSource = self
        cvHeros.delegate = self
        
        getHeroes()
        
        configureSearch()
        
    }
    
    func getHeroes() {
        viewModel.getHeroes { listHeroes in
            self.heroes = listHeroes
            self.cvHeros.reloadData()
        }
    }
    
    func configureSearch() {
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
   
}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        
        if let hero = heroes?[indexPath.row] {
            cell.setCell(with: hero)
        }

        return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let targetHero = heroes?[indexPath.row] {
            
            let controller = HeroDetailViewController()

            controller.hero = targetHero
            
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if !self.isSearching {
            
            if let herosSize = heroes?.count {
                
                if indexPath.row == herosSize / 2 {
                    
                    viewModel.getMoreHeroes(offset: herosSize) { listHeroes in
                        self.heroes?.append(contentsOf: listHeroes)
                        self.cvHeros.reloadData()
                    }
                    
                }
            }

        }
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 2 - 10, height: 200)
        
    }
    
}

extension ViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            heroes = []
            self.cvHeros.reloadData()
            
            //inserir animacao de loading
            viewModel.getHero(by: text) { listHeroes in
                self.isSearching = true
                self.heroes = listHeroes
                self.cvHeros.reloadData()
            }
            //encerrar animacao de loading
            
        } else{
            self.isSearching = false
            getHeroes()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
        getHeroes()
    }
}
