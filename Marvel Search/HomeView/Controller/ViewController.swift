//
//  ViewController.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tbvHeros: UITableView!
    
    var heros: Array<Hero> = []
    var detailController: HeroDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvHeros.dataSource = self
        tbvHeros.delegate = self
        buscarHerois()
    }
    
    func buscarHerois() {
        
        MarvelApi().getHeroes { listaDeHerois in
            self.heros = listaDeHerois
            self.tbvHeros.reloadData()
        }
        
    }
    
    
   

   
    //MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heros.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CelulaHeroi", for: indexPath) as! HeroTableViewCell
        
        cell.setCell(hero: heros[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetHero = heros[indexPath.row]
        
        detailController.hero = targetHero
    }
    
    
    //MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo"{
            detailController = segue.destination as? HeroDetailViewController
        }
    }
}

