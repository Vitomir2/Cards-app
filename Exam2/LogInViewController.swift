//
//  LogInViewController.swift
//  Exam2
//
//  Created by Vitomir on 2/18/17.
//  Copyright © 2017 Vitomir. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var cocoaButton: DynamicButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cocoaPod
        _ = DynamicButton(style: DynamicButtonStyle.hamburger)
        self.cocoaButton.setStyle(DynamicButtonStyle.download, animated: true)
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if let username = UserDefaults.standard.string(forKey: UserDefaultKeys.username.rawValue) {
            self.usernameTextField.text = username
        }
        if let password = UserDefaults.standard.string(forKey: UserDefaultKeys.password.rawValue){
            self.passwordTextField.text = password
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
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
        
        DBCommunication.instance.login(with: self.usernameTextField.text!, password: self.passwordTextField.text!)
        { (success) in
            if success == true {
                
                UserDefaults.standard.set(self.usernameTextField.text, forKey: UserDefaultKeys.username.rawValue)
                UserDefaults.standard.set(self.passwordTextField.text, forKey: UserDefaultKeys.password.rawValue)
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.autoLogingEnabled.rawValue)
                
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "LoginDoneSegue", sender: nil)
                }
            }
            else {
                let alert = UIAlertController.init(title: "Error", message: "Wrong username or password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}
