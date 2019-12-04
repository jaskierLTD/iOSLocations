//
//  SearchResultsController.swift
//  teamvoy
//
//  Created by Alessandro Marconi on 13/11/2019.
//  Copyright © 2019 OleksandrZheliezniak. All rights reserved.
//

import CoreLocation
import GooglePlaces
import UIKit

class SearchResultsController: UITableViewController {
    
    var searchResults: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = self.searchResults[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){
        self.dismiss(animated: true, completion: nil)
        // All this logic should go outside to networkmanager, over messy
        let urlpath = "https://maps.googleapis.com/maps/api/geocode/json?address=\(self.searchResults[indexPath.row])&key=AIzaSyBUJBryZEbNbkfV6NHQuhPVmuc9BnjxNBE&sensor=false".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlpath)
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
            
            if data != nil {
                do {
                    if data != nil
                    {
                        let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                        print(dic)
                        
                        let lat =   (((((dic.value(forKey: "results") as! NSArray)
                            .object(at: 0) as! NSDictionary)
                            .value(forKey: "geometry") as! NSDictionary)
                            .value(forKey: "location") as! NSDictionary)
                            .value(forKey: "lat")) as! Double
                    
                        let lon =   (((((dic.value(forKey: "results") as! NSArray)
                            .object(at: 0) as! NSDictionary)
                            .value(forKey: "geometry") as! NSDictionary)
                            .value(forKey: "location") as! NSDictionary)
                            .value(forKey: "lng")) as! Double

                        jsonURLString = "https://api.darksky.net/forecast/86f373a5742ca2ac810248dde73f9009/\(lat),\(lon)"// you can use append method for that
                        locationString = self.searchResults[indexPath.row]
                        savedToCoreData = false
                    }
                } catch {   print("Error")  }
            } else { print("Data answer from url request in 'TableView didSelectRowAt...' is empty") }
        }
        task.resume()
    }
    
    func reloadDataWithArray(_ array: [String]) {
        self.searchResults = array
        self.tableView.reloadData()
    }
}
