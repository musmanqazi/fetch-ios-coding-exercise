//
//  CustomTableViewCell.swift
//  Dessert Finder
//
//  Created by Usman Qazi on 6/14/24.
//

import UIKit

class CustomTableViewCell : UITableViewCell {
    
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var nameOfDessert : UILabel!
    @IBOutlet weak var numberOfIngredients : UILabel!
    @IBOutlet weak var countryOfOrigin : UILabel!
    
    var task : URLSessionDataTask?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
