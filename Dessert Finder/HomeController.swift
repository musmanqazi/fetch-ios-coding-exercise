//
//  ViewController.swift
//  Dessert Finder
//
//  Created by Usman Qazi on 6/14/24.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet var tableView : UITableView!
    var meal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        getDessertData()
    }
    
    func getDessertData() {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=53049")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("HTTP Request Error: \(error)")
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let jsonResponse = try decoder.decode(Response.self, from: data)
                    self.meal = jsonResponse.meals.first
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Decoding Error: \(error)")
                }
            } else {
                print("Unexpected HTTP Error")
            }
        }
        task.resume()
    }
}

struct Meal : Codable {
    var strMeal : String
    var strArea : String
    var strMealThumb : String
}

struct Response : Codable {
    var meals : [Meal]
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal == nil ? 0 : 1
    }
}

extension HomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameOfDessert.text = meal!.strMeal
//        cell.countryOfOrigin.text = meal!.strArea
        let countryFlags: [String: String] = [
            "Afghanistani": "🇦🇫", "Albanian": "🇦🇱", "Algerian": "🇩🇿", "Andorran": "🇦🇩", "Angolan": "🇦🇴",
            "Antiguan": "🇦🇬", "Argentinian": "🇦🇷", "Armenian": "🇦🇲", "Australian": "🇦🇺", "Austrian": "🇦🇹",
            "Azerbaijani": "🇦🇿", "Bahamian": "🇧🇸", "Bahraini": "🇧🇭", "Bangladeshi": "🇧🇩", "Barbadian": "🇧🇧",
            "Belarusian": "🇧🇾", "Belgian": "🇧🇪", "Belizean": "🇧🇿", "Beninese": "🇧🇯", "Bermudian": "🇧🇲", "Bhutanese": "🇧🇹",
            "Bolivian": "🇧🇴", "Bosnian": "🇧🇦", "Motswana": "🇧🇼", "Brazilian": "🇧🇷", "Bruneian": "🇧🇳",
            "Bulgarian": "🇧🇬", "Burkinabe": "🇧🇫", "Burundian": "🇧🇮", "Cambodian": "🇰🇭", "Cameroonian": "🇨🇲",
            "Canadian": "🇨🇦", "Cape Verdean": "🇨🇻", "Central African": "🇨🇫", "Chadian": "🇹🇩", "Chilean": "🇨🇱",
            "Chinese": "🇨🇳", "Colombian": "🇨🇴", "Comorian": "🇰🇲", "Congolese": "🇨🇬", "Congolese (Democratic Rep)": "🇨🇩",
            "Costa Rican": "🇨🇷", "Croatian": "🇭🇷", "Cuban": "🇨🇺", "Cypriot": "🇨🇾", "Czech": "🇨🇿",
            "Danish": "🇩🇰", "Djiboutian": "🇩🇯", "Dominican": "🇩🇲", "Dominican Republic": "🇩🇴", "East Timorese": "🇹🇱",
            "Ecuadorian": "🇪🇨", "Egyptian": "🇪🇬", "Salvadoran": "🇸🇻", "Equatorial Guinean": "🇬🇶", "Eritrean": "🇪🇷",
            "Estonian": "🇪🇪", "Eswatini": "🇸🇿", "Ethiopian": "🇪🇹", "Fijian": "🇫🇯", "Finnish": "🇫🇮", "French": "🇫🇷",
            "Gabonese": "🇬🇦", "Gambian": "🇬🇲", "Georgian": "🇬🇪", "German": "🇩🇪", "Ghanaian": "🇬🇭", "Greek": "🇬🇷",
            "Grenadian": "🇬🇩", "Guatemalan": "🇬🇹", "Guinean": "🇬🇳", "Guinea-Bissauan": "🇬🇼", "Guyanese": "🇬🇾",
            "Haitian": "🇭🇹", "Honduran": "🇭🇳", "Hungarian": "🇭🇺", "Icelander": "🇮🇸", "Indian": "🇮🇳", "Indonesian": "🇮🇩",
            "Iranian": "🇮🇷", "Iraqi": "🇮🇶", "Irish": "🇮🇪", "Israeli": "🇮🇱", "Italian": "🇮🇹",
            "Ivorian": "🇨🇮", "Jamaican": "🇯🇲", "Japanese": "🇯🇵", "Jordanian": "🇯🇴", "Kazakhstani": "🇰🇿",
            "Kenyan": "🇰🇪", "I-Kiribati": "🇰🇮", "North Korean": "🇰🇵", "South Korean": "🇰🇷", "Kosovar": "🇽🇰",
            "Kuwaiti": "🇰🇼", "Kyrgyz": "🇰🇬", "Laotian": "🇱🇦", "Latvian": "🇱🇻", "Lebanese": "🇱🇧", "Basotho": "🇱🇸",
            "Liberian": "🇱🇷", "Libyan": "🇱🇾", "Liechtensteiner": "🇱🇮", "Lithuanian": "🇱🇹", "Luxembourger": "🇱🇺",
            "Malagasy": "🇲🇬", "Malawian": "🇲🇼", "Malaysian": "🇲🇾", "Maldivian": "🇲🇻", "Malian": "🇲🇱",
            "Maltese": "🇲🇹", "Marshallese": "🇲🇭", "Mauritanian": "🇲🇷", "Mauritian": "🇲🇺", "Mexican": "🇲🇽",
            "Micronesian": "🇫🇲", "Moldovan": "🇲🇩", "Monégasque": "🇲🇨", "Mongolian": "🇲🇳", "Montenegrin": "🇲🇪",
            "Moroccan": "🇲🇦", "Mozambican": "🇲🇿", "Burmese": "🇲🇲", "Namibian": "🇳🇦", "Nauruan": "🇳🇷",
            "Nepalese": "🇳🇵", "Dutch": "🇳🇱", "New Zealander": "🇳🇿", "Nicaraguan": "🇳🇮", "Nigerien": "🇳🇪",
            "Nigerian": "🇳🇬", "Norwegian": "🇳🇴", "Omani": "🇴🇲", "Pakistani": "🇵🇰", "Palauan": "🇵🇼", "Palestinian": "🇵🇸",
            "Panamanian": "🇵🇦", "Papua New Guinean": "🇵🇬", "Paraguayan": "🇵🇾", "Peruvian": "🇵🇪", "Filipino": "🇵🇭",
            "Polish": "🇵🇱", "Portuguese": "🇵🇹", "Qatari": "🇶🇦", "Romanian": "🇷🇴", "Russian": "🇷🇺",
            "Rwandan": "🇷🇼", "Saint Kittsian & Nevisian": "🇰🇳", "Saint Lucian": "🇱🇨", "Saint Vincentian & Grenadine": "🇻🇨",
            "Samoan": "🇼🇸", "San Marinese": "🇸🇲", "Sao Tomean": "🇸🇹", "Saudi": "🇸🇦", "Senegalese": "🇸🇳", "Serbian": "🇷🇸", "Seychellois": "🇸🇨",
            "Sierra Leonean": "🇸🇱", "Singaporean": "🇸🇬", "Slovak": "🇸🇰", "Slovene": "🇸🇮", "Solomon Islander": "🇸🇧",
            "Somali": "🇸🇴", "South African": "🇿🇦", "South Sudanese": "🇸🇸", "Spanish": "🇪🇸", "Sri Lankan": "🇱🇰",
            "Sudanese": "🇸🇩", "Surinamese": "🇸🇷", "Swedish": "🇸🇪", "Swiss": "🇨🇭", "Syrian": "🇸🇾", "Taiwanese": "🇹🇼",
            "Tajik": "🇹🇯", "Tanzanian": "🇹🇿", "Thai": "🇹🇭", "Togolese": "🇹🇬", "Tongan": "🇹🇴", "Trinidadian & Tobagonian": "🇹🇹",
            "Tunisian": "🇹🇳", "Turkish": "🇹🇷", "Turkmen": "🇹🇲", "Tuvaluan": "🇹🇻", "Ugandan": "🇺🇬", "Ukrainian": "🇺🇦",
            "Emirati": "🇦🇪", "British": "🇬🇧", "American": "🇺🇸", "Uruguayan": "🇺🇾", "Uzbek": "🇺🇿", "Vanuatuan": "🇻🇺",
            "Vatican": "🇻🇦", "Venezuelan": "🇻🇪", "Vietnamese": "🇻🇳", "Yemeni": "🇾🇪", "Zambian": "🇿🇲", "Zimbabwean": "🇿🇼"
        ]
        
        if let emojiFlag = countryFlags[meal!.strArea] {
            let countryWithFlag = emojiFlag + " " + meal!.strArea
            cell.countryOfOrigin.text = countryWithFlag
        } else {
            cell.countryOfOrigin.text = meal!.strArea // Fallback to country name if emoji flag is not available
        }
        
        // Hide the ingredients count label for now since we're not using it
//        cell.numberOfIngredients.isHidden = true
        
        if let url = URL(string: meal!.strMealThumb + "/preview") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    OperationQueue.main.addOperation {
                        cell.thumbnailImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
        return cell
    }
}
