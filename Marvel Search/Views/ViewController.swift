//
//  ViewController.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var cvHeros: UICollectionView!

    @IBOutlet weak var aiSpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var lblNotFound: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching = false
    
    var heroes: [Character]?
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvHeros.dataSource = self
        cvHeros.delegate = self
        
        lblNotFound.isHidden = true
        
        getHeroes()
        
        configureSearch()
        
    }
    
    func getHeroes() {
        loadingData(true)
        viewModel.getHeroes { listHeroes in
            self.lblNotFound.isHidden = true
            self.heroes = listHeroes
            self.cvHeros.reloadData()
            self.loadingData(false)
        }
    }
    
    func configureSearch() {
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
    func loadingData(_ loading: Bool){
        cvHeros.isHidden = loading
        loading ? aiSpinner.startAnimating() : aiSpinner.stopAnimating()
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
            
            loadingData(true)
            
            cvHeros.reloadData()
            
            viewModel.getHero(by: text) { listHeroes in
                
                self.loadingData(false)
                if listHeroes.count > 0 {
                    self.lblNotFound.isHidden = true
                    self.isSearching = true
                    self.heroes = listHeroes
                    self.cvHeros.reloadData()
                }
                else{
                    self.lblNotFound.isHidden = false
                }
            }
            
        } else{
            isSearching = false
            getHeroes()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        getHeroes()
    }
}
