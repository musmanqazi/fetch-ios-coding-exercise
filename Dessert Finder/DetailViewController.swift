//
//  DetailViewController.swift
//  Dessert Finder
//
//  Created by Usman Qazi on 6/18/24.
//

import UIKit

class DetailViewController : UIViewController {
    
    var meal: Meal?
        
    @IBOutlet weak var nameOfDessert : UILabel!
    @IBOutlet weak var dessertImage : UIImageView!
    @IBOutlet weak var countryOfOrigin : UILabel!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let meal = meal else { return }
        
        nameOfDessert.text = meal.strMeal
        
        if let area = meal.strArea {
            if let emojiFlag = Utilities.countryFlags[area] {
                countryOfOrigin.text = "\(emojiFlag) \(area)"
            } else {
                countryOfOrigin.text = area
            }
        }
        
        if let imageUrlString = meal.strMealThumb, let imageUrl = URL(string: imageUrlString) {
            activityIndicator.startAnimating()
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.dessertImage.image = image
                        self.activityIndicator.stopAnimating()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
}
