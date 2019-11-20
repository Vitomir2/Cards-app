//
//  RegisterViewController.swift
//  Exam2
//
//  Created by Vitomir on 2/18/17.
//  Copyright © 2017 Vitomir. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    var dataDictionary:[String: Any?]! = [String: Any?]()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard usernameTextField.text!.characters.count > 0 else {
            
            let alert = UIAlertController.init(title: "Error", message: "Username too short", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        guard passwordTextField.text!.characters.count > 0 else {
            
            let alert = UIAlertController.init(title: "Error", message: "Password too short", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        guard passwordAgainTextField.text! == passwordTextField.text! else {
            
            let alert = UIAlertController.init(title: "Error", message: "Password doesn't much!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        self.dataDictionary[UserDefaultKeys.username.rawValue] = self.usernameTextField.text
        self.dataDictionary[UserDefaultKeys.name.rawValue] = self.nameTextField.text
        self.dataDictionary[UserDefaultKeys.password.rawValue] = self.passwordTextField.text
        self.dataDictionary[UserDefaultKeys.passwordAgain.rawValue] = self.passwordAgainTextField.text
        self.dataDictionary[UserDefaultKeys.phoneNumber.rawValue] = self.phoneNumber.text
        
        DBCommunication.instance.sendInfoToDB(info: self.dataDictionary)
        
        _ = self.navigationController?.popToRootViewController(animated: true)
        
        self.modalTransitionStyle = .crossDissolve
        self.present(UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
    }
    
}
