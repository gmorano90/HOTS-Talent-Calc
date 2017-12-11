//
//  HeroCell.swift
//  HOTS-Talent-Calc
//
//  Created by Greg Morano on 7/28/17.
//  Copyright © 2017 Greg Morano. All rights reserved.
//

import UIKit

class HeroCell: UITableViewCell {

    @IBOutlet weak var heroLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroClassImageView: UIImageView!
    
    

    
    var hero: BasicHero! {
        didSet {
            heroLabel.text = hero.name
            //heroImageView.contentMode = UIViewContentMode.scaleAspectFit
            //heroClassImageView.contentMode = UIViewContentMode.scaleAspectFit
            heroImageView.image = imageForHero(name: hero.name!)
            heroClassImageView.image = imageForHero(name: hero.type!)
        }
    }
    
    func imageForHero(name:String) -> UIImage? {
        let imageName = "\(name.lowercased())"
        return UIImage(named: imageName)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
