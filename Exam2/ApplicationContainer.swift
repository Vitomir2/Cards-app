//
//  ApplicationContainer.swift
//  Exam2
//
//  Created by Vitomir on 2/18/17.
//  Copyright © 2017 Vitomir. All rights reserved.
//

import UIKit

class ApplicationContainer: UIViewController {

    var userLoggedIn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if let autoUserLoginEnabled = UserDefaults.standard.object(forKey: UserDefaultKeys.autoLogingEnabled.rawValue) as? Bool{
            self.userLoggedIn = autoUserLoginEnabled
        }
        else {
            self.userLoggedIn = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userLoggedIn == true {
            self.performSegue(withIdentifier: "ToMainScreenSegue", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "ToLoginViewController", sender: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
