//
//  MakePurchaseViewController.swift
//  Exam2
//
//  Created by Vitomir on 2/18/17.
//  Copyright © 2017 Vitomir. All rights reserved.
//

import UIKit

class MakePurchaseViewController: UIViewController {

    var dataDictionary:[String: Any?]! = [String: Any?]()
    
    @IBOutlet weak var recepientTextField: UITextField!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var favColorTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var cardSenderTextField: UITextField!
    @IBOutlet weak var luxuryLevelSlider: UISlider!
    @IBOutlet weak var luxuryLabel: UILabel!
    
    var gender = "Female"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func genderSelection(_ sender: UISegmentedControl) {
        if genderSegmentControl.selectedSegmentIndex == 0
        {
            gender = "Male"
        }
        if genderSegmentControl.selectedSegmentIndex == 1
        {
            gender = "Female"
        }
    }
    
    func getGender() -> String {
        return gender
    }
    
    @IBAction func luxuryLeveMoving(_ sender: UISlider) {
        luxuryLabel.text = String(luxuryLevelSlider.value)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dataDictionary[DataNames.recepient.rawValue] = self.recepientTextField.text
        self.dataDictionary[DataNames.gender.rawValue] = self.genderSegmentControl.selectedSegmentIndex
        self.dataDictionary[DataNames.favoriteColor.rawValue] = self.favColorTextField.text
        self.dataDictionary[DataNames.messageForRecepient.rawValue] = self.messageTextField.text
        self.dataDictionary[DataNames.cardSender.rawValue] = self.cardSenderTextField.text
        self.dataDictionary[DataNames.luxuryLevel.rawValue] = self.luxuryLevelSlider.value
        
        DBCommunication.instance.sendInfoCardToDB(info: self.dataDictionary)
        
        _ = self.navigationController?.popToRootViewController(animated: true)
    }

}
