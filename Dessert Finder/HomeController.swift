//
//  ViewController.swift
//  Dessert Finder
//
//  Created by Usman Qazi on 6/14/24.
//

import UIKit
import CryptoKit

class MyConnection {
    static func loadData(
        from url: URL,
        completion: @escaping (Data?, URLResponse?, Error?) -> ()
    )
    {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            
            OperationQueue.main.addOperation {
                completion(data, response, error)
            }
        }
        task.resume()
    }
}

class MyPersistence
{
    static func stringToHashString(_ s: String) -> String
    {
        let data = s.data(using: String.Encoding.utf8)!
        let hash = SHA512.hash(data: data)
        let hashString = hash.map {
            String(format: "%02hhc", $0)
        }.joined()
        
        return hashString
    }
        
    func makeFileCacheURL(_ fileKey: String) -> URL
    {
        let cacheDirs = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        
        let cacheDir = cacheDirs.first!
        let fileNameHash = MyPersistence.stringToHashString(fileKey)
        let cachePath = cacheDir.appendingPathComponent(fileNameHash)
        
        return cachePath
    }
    
    func isFileCache(fileKey: String) -> Bool
    {
        let cacheURL = self.makeFileCacheURL(fileKey)
        let exists = FileManager.default.fileExists(atPath: cacheURL.path)
        return exists
    }
    
    func saveFileToCache(fileKey: String, fileData: Data?, overwrite: Bool = false)
    {
        if let fileDataSafe = fileData
        {
            let cacheURL = self.makeFileCacheURL(fileKey)
            
            if ( overwrite == false && self.isFileCache(fileKey: fileKey) )
            {
                return
            }
            
            do
            {
                try fileDataSafe.write(to: cacheURL, options: NSData.WritingOptions.atomic)
                print("File was saved to cache: \(cacheURL)")
            }
            catch
            {
                print("Error: \(error)")
            }
        }
    }
    
    func loadFileFromCache(fileKey: String) -> Data?
    {
        let cacheURL = self.makeFileCacheURL(fileKey)
        
        do
        {
            let fileData = try Data(contentsOf: cacheURL)
            print("Loading file data directly from cacheURL: \(cacheURL)")
            return fileData
        }
        catch
        {
            return nil
        }
    }
    
    func loadFileToCache(urlAsString: String, completion: @escaping (Data) -> () )
    {
        let fileURL = URL(string: urlAsString)!
        
        MyConnection.loadData(from: fileURL)
        {
            (data, repsonse, error) in
            
            if let theError = error {
                print("error loading file: \(theError)")
            }
            else if (data != nil) {
                self.saveFileToCache(fileKey: urlAsString, fileData: data)
                print("Loaded from URL \(urlAsString) and saved to cache.")
                OperationQueue.main.addOperation {
                    completion(data!)
                }
            }
        }
    }

}

class HomeController: UIViewController {

    @IBOutlet var tableView : UITableView!
    
    var meals : [Meal] = []
    
    var myPersistence = MyPersistence()
    
    var imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDessertData()
    }
    
    func getDessertData() {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("HTTP Request Error: \(error)")
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let jsonResponse = try decoder.decode(Response.self, from: data)
                    self.meals = jsonResponse.meals
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                        self.getAdditionalDessertData()
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
    
    func getAdditionalDessertData () {
        for index in 0..<meals.count {
            let meal = meals[index]
            let lookupURL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)")!
            let request = URLRequest(url: lookupURL)

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("HTTP Request Error: \(error)")
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let jsonResponse = try decoder.decode(Response.self, from: data)
                        if let mealDetails = jsonResponse.meals.first {
                            self.meals[index].strArea = mealDetails.strArea
                            OperationQueue.main.addOperation {
                                self.tableView.reloadData()
                            }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let destinationVC = segue.destination as? DetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.meal = meals[indexPath.row]
        }
    }
}

struct Meal : Codable {
    var strMeal : String
    var strMealThumb : String?
    var idMeal : String
    var strArea : String?
}

struct Response : Codable {
    var meals : [Meal]
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
}

extension HomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let meal = meals[indexPath.row]
        
        cell.nameOfDessert.text = meal.strMeal
        cell.countryOfOrigin.isHidden = true
        
        
        
        if meal.strArea != nil {
            if let emojiFlag = Utilities.countryFlags[meal.strArea!] {
                let countryWithFlag = "\(emojiFlag) \(meal.strArea!)"
                cell.countryOfOrigin.text = countryWithFlag
            } else {
                cell.countryOfOrigin.text = meal.strArea
            }
            cell.countryOfOrigin.isHidden = false
        }
        
        cell.thumbnailImage.image = nil
        cell.currentImageURL = meal.strMealThumb

        guard let mealThumbURL = meal.strMealThumb else {
            return cell
        }
        
        if let cachedImage = imageCache.object(forKey: mealThumbURL as NSString) {
            cell.activityIndicator.startAnimating()
            if cell.currentImageURL == meal.strMealThumb {
                cell.thumbnailImage.image = cachedImage
                cell.activityIndicator.stopAnimating()
                print("Success! Loaded file directly from cache for \(meal.strMeal).")
            }
        } else {
            if let url = URL(string: mealThumbURL) {
                cell.activityIndicator.startAnimating()
                MyConnection.loadData(from: url) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        self.imageCache.setObject(image, forKey: mealThumbURL as NSString)
                        if cell.currentImageURL == meal.strMealThumb {
                            DispatchQueue.main.async {
                                cell.thumbnailImage.image = image
                                cell.activityIndicator.stopAnimating()
                                print("Success! Loaded file from URL and saved to cache for \(meal.strMeal).")
                            }
                        }
                    } else {
                        print("Error loading image: \(String(describing: error))")
                    }
                }
            }
        }
        
//        cell.numberOfIngredients.isHidden = true
        
        return cell
    }
}
