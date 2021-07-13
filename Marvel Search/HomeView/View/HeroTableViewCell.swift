//
//  HeroTableViewCell.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit
import AlamofireImage

class HeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblHeroName: UILabel!
    
    @IBOutlet weak var imgHeroPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(hero: Hero) {
        lblHeroName.text = hero.name
        
        guard let imageUrl = hero.getURLforThumbnail() else { return }
        imgHeroPic.af.setImage(withURL: imageUrl)
    }

}
