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
    @IBOutlet weak var lblDescriptionHero: UILabel!
    @IBOutlet weak var tbComics: UITableView!
    
    @IBOutlet weak var lblTitleDescriptionHe: UILabel!
    @IBOutlet weak var viewSeparatorTitleDescriptionHero: UIView!
    
    @IBOutlet weak var lblTitleComics: UILabel!
    @IBOutlet weak var viewSeparatorComics: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbComics.delegate = self
        tbComics.dataSource = self
        tbComics.register(UINib(nibName: "ComicsTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    
    }
    
    func inicializeComponents(){
        title = hero!.name
        
        guard let imageUrl = hero!.getURLforThumbnail() else { return }
        
        imgHero.af.setImage(withURL: imageUrl)
        
        if hero!.heroDescription.isEmpty {
            lblTitleDescriptionHe.isHidden = true
            viewSeparatorTitleDescriptionHero.isHidden = true
            lblDescriptionHero.isHidden = true
            
        } else {
            lblDescriptionHero.isHidden = false
            lblTitleDescriptionHe.isHidden = false
            viewSeparatorTitleDescriptionHero.isHidden = false
            lblDescriptionHero.text = hero!.heroDescription
        }
        
        if hero!.comicList.isEmpty {
            lblTitleComics.isHidden = true
            viewSeparatorComics.isHidden = true
        } else{
            lblTitleComics.isHidden = false
            viewSeparatorComics.isHidden = false
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
