//
//  WeatherView.swift
//  iOSLocations
//
//  Created by ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ on 01.12.2019.
//  Copyright © 2019 ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import GoogleMaps
import GooglePlaces
// not here, messy, external manager for that
public var locationString = "Please wait..."
public var savedToCoreData = false
public var newLocation = true
public var jsonURLString = "https://api.darksky.net/forecast/86f373a5742ca2ac810248dde73f9009/0.0000,0.0000"

class WeatherView: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    // MARK: - Search Bar
    // mark everything you can private
    var searchResultController: SearchResultsController!
    var resultsArray: [String] = []
    
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    @IBAction func searchWithAddress(_ sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.present(searchController, animated: true, completion: nil)
    }
    
    // MARK:  - Weather Infromations
    // names are not informative, why you didn't add labels on storyboard
    let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let label4 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let label5 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let label6 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let label7 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let label8 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    let locationManager = CLLocationManager()
    var listItems = [NSManagedObject]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        searchResultController = SearchResultsController()
    }
    
    // MARK:  - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initializing empty labels
        // messy, no autolayout for labels
        label1.center = CGPoint(x: 160, y: 285)
        label1.textAlignment = .center
        label1.text = ""
        label1.font = label1.font.withSize(14)
        label1.center.x = self.view.center.x-50
        label1.center.y = self.view.center.y-125
        self.view.addSubview(label1)
        
        label2.center = CGPoint(x: 160, y: 285)
        label2.textAlignment = .center
        label2.text = ""
        label2.font = label2.font.withSize(14)
        label2.center.x = self.view.center.x-50
        label2.center.y = self.view.center.y-100
        self.view.addSubview(label2)
        
        label3.center = CGPoint(x: 160, y: 285)
        label3.textAlignment = .center
        label3.text = ""
        label3.font = label3.font.withSize(14)
        label3.center.x = self.view.center.x-50
        label3.center.y = self.view.center.y-75
        self.view.addSubview(label3)
        
        label4.center = CGPoint(x: 160, y: 285)
        label4.textAlignment = .center
        label4.text = ""
        label4.font = label4.font.withSize(14)
        label4.center.x = self.view.center.x-50
        label4.center.y = self.view.center.y-50
        self.view.addSubview(label4)
        
        label5.center = CGPoint(x: 160, y: 285)
        label5.textAlignment = .center
        label5.text = ""
        label5.font = label5.font.withSize(14)
        label5.center.x = self.view.center.x-50
        label5.center.y = self.view.center.y-25
        self.view.addSubview(label5)
        
        label6.center = CGPoint(x: 160, y: 285)
        label6.textAlignment = .center
        label6.text = ""
        label6.font = label6.font.withSize(14)
        label6.center.x = self.view.center.x-50
        label6.center.y = self.view.center.y
        self.view.addSubview(label6)
        
        label7.center = CGPoint(x: 160, y: 285)
        label7.textAlignment = .center
        label7.text = ""
        label7.font = label7.font.withSize(14)
        label7.center.x = self.view.center.x-50
        label7.center.y = self.view.center.y+25
        self.view.addSubview(label7)
        
        label8.center = CGPoint(x: 160, y: 285)
        label8.textAlignment = .center
        label8.text = ""
        label8.font = label8.font.withSize(14)
        label8.center.x = self.view.center.x-50
        label8.center.y = self.view.center.y+50
        self.view.addSubview(label8)
        
        // Run for use in foreground
        if newLocation { //also works :)
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
            
            // Get current location and adress only once before user did search
            let manager = CLLocationManager()
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            jsonURLString = "https://api.darksky.net/forecast/86f373a5742ca2ac810248dde73f9009/\(locValue.latitude),\(locValue.longitude)" // separate string
            getAddressFromLatLon(pdblLatitude: String(locValue.latitude), withLongitude: String(locValue.longitude))
        }
        else{
            // We are reading from CoreData
            locationManager.stopUpdatingLocation()
            label1.text = locationString
        }
    }
    
    // MARK: - Location Manager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locationString)
        // lol, it's everywhere)
        if savedToCoreData {
            self.indicator.stopAnimating()
        } else {
            self.indicator.startAnimating()
        }
        
        guard let url = URL(string: jsonURLString) else { return }
         URLSession.shared.dataTask(with: url) { (data, response, err) in
             guard let data = data else { return }
             do {
                 let result = try JSONDecoder().decode(Result.self, from: data)
                 DispatchQueue.main.async {
                    // you know what :)
                    // and locationString != "Please wait..." you don't need it, don't use it for logic
                    if !savedToCoreData && locationString != "Please wait..." && self.cleanEntity(location: locationString) {
                        print("Saving to CoreData...")
                        self.saveItem(locationToSave: locationString, latitudeToSave: result.latitude!, longitudeToSave: result.longitude!, iconToSave: result.icon!, temperatureToSave: result.temperature!, humidityToSave: result.humidity!, windSpeedToSave: result.humidity!, summaryToSave: result.summary!)
                        
                        savedToCoreData = true
                    }
                    else {  //Do not save to CoreData
                    }
                    
                    // This is request for WeatherAPI, therefore we have only timezone name (Europe/Asia etc.)
                    // tooo messy, force unwraping also everywhere
                    self.label1.text = "Location: \(locationString)."
                    self.label1.textColor = .blue
                    let range = (self.label1.self.text! as NSString).range(of: locationString)
                    let attributedString = NSMutableAttributedString(string:self.label1.self.text!)
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray , range: range)
                    self.label1.attributedText = attributedString
                    self.label1.sizeToFit()
                      
                    self.label2.textColor = .blue
                    self.label2.text = "lat: \(result.latitude!)"
                    self.label2.sizeToFit()
                      
                    self.label3.textColor = .blue
                    self.label3.text = "lot: \(result.longitude!)"
                    self.label3.sizeToFit()
                      
                    self.label4.textColor = .darkGray
                    self.label4.text = "icon: \(result.icon!)"
                    self.label4.sizeToFit()
                    self.backgroundImage.image = UIImage(named: result.icon!)
                      
                    self.label5.textColor = .green
                    self.label5.text = "Temperature: \(result.temperature!)"
                    self.label5.sizeToFit()
                      
                    self.label6.textColor = .green
                    self.label6.text = "Humidity: \(result.humidity!)"
                    self.label6.sizeToFit()
                      
                    self.label7.textColor = .green
                    self.label7.text = "Wind speed: \(result.windSpeed!)"
                    self.label7.sizeToFit()
                      
                    self.label8.textColor = .lightGray
                    self.label8.text = "Summary: \(result.summary!)"
                    self.label8.sizeToFit()
                 }
             } catch let jsonErr {
                 print("Error serializing json:", jsonErr)
             }
         }.resume()
    }
    
    // MARK: - get Address From Coordinates
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        // pdblLatitude is already String type
        let lat = Double(pdblLatitude) ?? 0.0
        let lon = Double(pdblLongitude) ?? 0.0
        let geo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        // code style
        geo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in

                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0
                {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    locationString = addressString
              }
        })
    }
    
    // MARK: - searchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let placeClient = GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error: Error?) -> Void in
            
            self.resultsArray.removeAll()
            if results == nil {
                return
            }
            
            for result in results! {
                if let result = result as GMSAutocompletePrediction? {
                    self.resultsArray.append(result.attributedFullText.string)
                }
                self.searchResultController.reloadDataWithArray(self.resultsArray)
            }
        }
    }
    
    // MARK: - saveContext
    
    func saveItem(locationToSave: String, latitudeToSave: Double, longitudeToSave: Double, iconToSave: String, temperatureToSave: Double, humidityToSave: Double, windSpeedToSave: Double, summaryToSave: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = (appDelegate).persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ListEntity", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        item.setValue(locationToSave, forKey: "location")
        item.setValue(latitudeToSave, forKey: "lat")
        item.setValue(longitudeToSave, forKey: "lon")
        item.setValue(iconToSave, forKey: "icon")
        item.setValue(humidityToSave, forKey: "humidity")
        item.setValue(temperatureToSave, forKey: "temperature")
        item.setValue(windSpeedToSave, forKey: "wind")
        item.setValue(summaryToSave, forKey: "summary")
        do{
            try managedContext.save()
            listItems.append(item)
        }
        catch{
            print("saveItem error occured in catch")
        }
    }
    
    func cleanEntity(location: String) -> Bool{
        var clean = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = (appDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ListEntity")
        let predicate = NSPredicate(format: "location == %@", location)
        request.predicate = predicate
        request.fetchLimit = 1

        do{
            let count = try managedContext.count(for: request)
            if(count == 0){ clean = true } // code style again
            else{
                clean = false
                self.indicator.stopAnimating()
                print("This value is already exist at CoreData")
            }
        }
        catch let error as NSError {
             print("Could not fetch \(error), \(error.userInfo)")
        }
        return clean
    }

}
