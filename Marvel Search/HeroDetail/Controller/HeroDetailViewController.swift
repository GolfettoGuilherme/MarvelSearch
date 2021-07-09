//
//  HeroDetailViewController.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 08/07/21.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    var hero:Hero?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = hero?.name
    }
    
}
