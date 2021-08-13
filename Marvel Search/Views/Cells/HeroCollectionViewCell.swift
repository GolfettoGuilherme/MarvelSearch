//
//  HeroCollectionViewCell.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 13/07/21.
//

import UIKit
import AlamofireImage

class HeroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblHero: UILabel!
    @IBOutlet weak var imgHero: UIImageView!
    
    func setCell(with hero: Character) {
        lblHero.text = hero.name
        
        guard let imageUrl = hero.thumbnail?.getURLforThumbnail() else { return }
        
        imgHero.af.setImage(withURL: imageUrl)
        
        //contentView.backgroundColor?.cgColor = CGColor()
    }
}
