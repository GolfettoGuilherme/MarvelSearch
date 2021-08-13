//
//  HeroDetailViewController.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit
import AlamofireImage

class HeroDetailViewController: UIViewController {
    
    var hero:Character?
    
    let cellId = "celulaComics"

    @IBOutlet weak var imgHero: UIImageView!
    
    @IBOutlet weak var lblHeroDescriptionTitle: UILabel!
    @IBOutlet weak var lblSeparatorHeroDescription: UIView!
    @IBOutlet weak var lblHeroDescription: UILabel!
    
    @IBOutlet weak var lblComicsrelatedTitle: UILabel!
    @IBOutlet weak var lblSeparatorComicsRelated: UIView!
    
    @IBOutlet weak var tbComics: AutoSizingUITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbComics.delegate = self
        tbComics.dataSource = self
        tbComics.register(UINib(nibName: "ComicsTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        inicializeComponents()
        
    }
    
    func inicializeComponents(){
        
        title = hero!.name
        
        guard let imageUrl = hero!.thumbnail!.getURLforThumbnail() else { return }
        
        imgHero.af.setImage(withURL: imageUrl)
        
        if let description = hero?.description {
            lblHeroDescriptionTitle.isHidden = false
            lblSeparatorHeroDescription.isHidden = false
            lblHeroDescription.isHidden = false
            lblHeroDescription.text = description
        } else{
            lblHeroDescriptionTitle.isHidden = true
            lblSeparatorHeroDescription.isHidden = true
            lblHeroDescription.isHidden = true
        }
        
        if hero!.comics!.items != nil {
            lblComicsrelatedTitle.isHidden = false
            lblSeparatorComicsRelated.isHidden = false
        } else{
            lblComicsrelatedTitle.isHidden = true
            lblSeparatorComicsRelated.isHidden = true
        }
        
        
    }

}

extension HeroDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let size = hero!.comics?.items?.count else { return 0 }
        
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaComics", for: indexPath) as! ComicsTableViewCell
        
        guard let comicName = hero!.comics?.items?[indexPath.row] else { return cell }
        
        cell.lblComicName.text = comicName.name
        
        return cell
    }
    
}
