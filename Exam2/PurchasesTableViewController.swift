//
//  PurchasesTableViewController.swift
//  Exam2
//
//  Created by Vitomir on 2/18/17.
//  Copyright © 2017 Vitomir. All rights reserved.
//

import UIKit

class PurchasesTableViewController: UITableViewController {

    var items: [String]! = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DBCommunication.instance.getAllInfo()
        
        NotificationCenter.default.addObserver(forName: .DataReloaded, object: nil, queue: nil) {
            (notification) in
            
            self.loadData()
            self.tableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailsSegue"{
            (segue.destination as! DetailsTableViewController).itemid  = sender as! String
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasesCellIdentifier", for: indexPath) -- bez obj C klasa
        //cell.textLabel?.text = self.items[indexPath.row] -- bez Obj C
        
        // s obj C klasa
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasesCellIdentifier", for: indexPath) as! LogItemTableViewCell
        cell.setupCell(withInfo: self.items[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsTableViewController") as! DetailsTableViewController
        
        detailViewController.itemid = self.items[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func loadData(){
        self.items = DBCommunication.instance.allDataItems.sorted()
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.autoLogingEnabled.rawValue)
        self.modalTransitionStyle = .crossDissolve
        self.present(UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
    }

}
