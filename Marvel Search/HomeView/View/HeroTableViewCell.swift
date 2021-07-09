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
        
        var urlFormatada = hero.thumbnail
        
        if urlFormatada.hasPrefix("http://") {
            urlFormatada = urlFormatada.replacingOccurrences(of: "http:", with: "https:")
        }
        
        guard let imageUrl = URL(string: urlFormatada) else { return }
        imgHeroPic.af.setImage(withURL: imageUrl)
    }

}
