//
//  ViewController.swift
//  Core Data Example
//
//  Created by Paige Plander on 3/4/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class SaveDogViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var furSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // need to use the Text Field delegate to resign the keyboard when pressing return
        dogNameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetUI()
    }

    func resetUI() {
        ageLabel.text = "\(0)"
        dogNameTextField.text = ""
        furSwitch.isOn = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func ageStepperValueChanged(_ sender: UIStepper) {
        // display the age the user has picked
        ageLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func saveDogButtonPressed(_ sender: UIButton) {
        // saves the dog the user inputted as a Dog Object in core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (dogNameTextField.text != "") {
            // use the context to store the dog
            let context =  appDelegate.persistentContainer.viewContext
            let dog = Dog(context: context) // Link Dog & Context
            dog.name = dogNameTextField.text
            dog.hasFur = furSwitch.isOn
            dog.age = Int16(ageLabel.text!)!
            // save the dog to core data. Check out the saveContext method in AppDelegate.swift
            appDelegate.saveContext()
            let alert = UIAlertController(title: "Dog Saved", message: "You can view \(dog.name!) by clicking `View Dogs`", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        resetUI()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

