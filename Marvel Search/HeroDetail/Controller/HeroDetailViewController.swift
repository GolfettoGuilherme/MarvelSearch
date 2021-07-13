//
//  HeroDetailViewController.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit
import AlamofireImage

class HeroDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
        
    var hero:Hero?

    @IBOutlet weak var imgHero: UIImageView!
    @IBOutlet weak var lblDescriptionHero: UILabel!
    @IBOutlet weak var tbComics: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbComics.delegate = self
        tbComics.dataSource = self
        
        inicializeComponents()
    }
    //MARK: - Metodos

    func inicializeComponents(){
        
        title = hero!.name
        
        guard let imageUrl = hero!.getURLforThumbnail() else { return }
        imgHero.af.setImage(withURL: imageUrl)
        
        //lblDescriptionHero.text = hero!.heroDescription
    }
    
    //MARK: - TableView

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
