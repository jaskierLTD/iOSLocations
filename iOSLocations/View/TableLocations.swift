//
//  TableLocations.swift
//  iOSLocations
//
//  Created by ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ on 01.12.2019.
//  Copyright © 2019 ᴀʟᴇxᴀɴᴅʀ ᴢʜᴇʟɪᴇᴢɴɪᴀᴋ. All rights reserved.
//

import CoreData
import UIKit

class TableLocations: UITableViewController {
    
    var listItems: [NSManagedObject] = [] // more preferable
    // but not here, some core data manager
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBAction func addLocation(_ sender: Any) {
        // hardcast is bad , use save unwrap and for "withIdentifier" use vc name
        guard let nextView = self.storyboard?.instantiateViewController(withIdentifier: "weatherID") as? WeatherView else { return }
//        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "weatherID") as! WeatherView
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        //better to move coredata logic to separate manager
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = (appDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ListEntity")
        do{
            let result = try managedContext.fetch(fetchRequest)
            listItems = result as! [NSManagedObject]
        }
        catch{
            print("error in viewDidAppear fetch")
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1 // is by default , can be removed
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = listItems[indexPath.row]
        cell.textLabel?.text = item.value(forKey: "location") as? String
        cell.detailTextLabel?.text = item.value(forKey: "summary") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = listItems[indexPath.row]
        locationString = (item.value(forKey: "location") as? String)!
        newLocation = false
        let weatherView = self.storyboard?.instantiateViewController(withIdentifier: "weatherID") as! WeatherView // same with this , don't force unwrap 
        self.navigationController?.pushViewController(weatherView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = (appDelegate).persistentContainer.viewContext
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.right)
        managedContext.delete(listItems[indexPath.row])
        listItems.remove(at: indexPath.row)
        
        self.tableView.reloadData()
        do{     try managedContext.save()                   } // code style
        catch{  print("saveItem error occured in catch")    }
    }

}
