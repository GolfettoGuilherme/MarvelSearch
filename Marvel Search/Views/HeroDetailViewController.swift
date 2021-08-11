//
//  HeroDetailViewController.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit
import AlamofireImage

class HeroDetailViewController: UIViewController {
    var hero:Hero?
    
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
        
        guard let imageUrl = hero!.getURLforThumbnail() else { return }
        
        imgHero.af.setImage(withURL: imageUrl)
        
        if hero!.heroDescription.isEmpty {
            lblHeroDescriptionTitle.isHidden = true
            lblSeparatorHeroDescription.isHidden = true
            lblHeroDescription.isHidden = true
        } else {
            lblHeroDescriptionTitle.isHidden = false
            lblSeparatorHeroDescription.isHidden = false
            lblHeroDescription.isHidden = false
            lblHeroDescription.text = hero!.heroDescription
        }
        
        if hero!.comicList.isEmpty {
            lblComicsrelatedTitle.isHidden = true
            lblSeparatorComicsRelated.isHidden = true
        } else{
            lblComicsrelatedTitle.isHidden = false
            lblSeparatorComicsRelated.isHidden = false
        }
        
        
    }

}

extension HeroDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let size = hero?.comicList.count else { return 0 }
        
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaComics", for: indexPath) as! ComicsTableViewCell
        
        guard let comicName = hero?.comicList[indexPath.row] else { return cell }
        
        cell.lblComicName.text = comicName.name
        
        return cell
    }
    
}
