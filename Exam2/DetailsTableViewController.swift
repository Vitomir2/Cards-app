//
//  DetailsTableViewController.swift
//  Exam2
//
//  Created by Vitomir on 2/18/17.
//  Copyright © 2017 Vitomir. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    var itemid:String! = String()
    var data: [String: Any?]! = [String:Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBCommunication.instance.getInfoForItem(itemId: itemid) { (receivedData) in
            guard receivedData != nil else {return}
            self.data = receivedData
            self.tableView.reloadData()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCellIdentifier", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = DataNames.recepient.rawValue
            cell.detailTextLabel?.text = (self.data[DataNames.recepient.rawValue] as? String)
        case 1:
            cell.textLabel?.text = DataNames.gender.rawValue
            cell.detailTextLabel?.text = (self.data[DataNames.gender.rawValue] as? String)
        case 2:
            cell.textLabel?.text = DataNames.favoriteColor.rawValue
            cell.detailTextLabel?.text = (self.data[DataNames.favoriteColor.rawValue] as? String)
        case 3:
            cell.textLabel?.text = DataNames.messageForRecepient.rawValue
            cell.detailTextLabel?.text = (self.data[DataNames.messageForRecepient.rawValue] as? String)
        case 4:
            cell.textLabel?.text = DataNames.cardSender.rawValue
            cell.detailTextLabel?.text = (self.data[DataNames.cardSender.rawValue] as? String)
        case 5:
            cell.textLabel?.text = DataNames.luxuryLevel.rawValue
            cell.detailTextLabel?.text = String(self.data[DataNames.luxuryLevel.rawValue]! as! Double)
        default:
            break
        }
        
        return cell
    }

}
