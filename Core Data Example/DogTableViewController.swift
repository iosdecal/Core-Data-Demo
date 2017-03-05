//
//  DogTableViewController.swift
//  Core Data Example
//
//  Created by Paige Plander on 3/4/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class DogTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let dogs = ["John", "Molly", "Henry"]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var savedDogs: [Dog] = []
    
    @IBOutlet weak var dogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogTableView.delegate = self
        dogTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        // method I created below to get all of the saved dog objects from core data
        fetchDogsFromCoreData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedDogs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = dogTableView.dequeueReusableCell(withIdentifier: "dogCell") as? DogTableViewCell {
            let dog = savedDogs[indexPath.row]
            cell.dogNameLabel.text = dog.name
            cell.dogAgeLabel.text = "Age: \(dog.age)"
            cell.dogHasFurLabel.text = "Has fur?    \(dog.hasFur)"
            cell.dogImageView.image = UIImage(named: dog.name!) ?? UIImage(named: "default")
            cell.isUserInteractionEnabled = true
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dog = savedDogs[indexPath.row]
            context.delete(dog)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            // now that we've deleted a dog, need to update the savedDogs array again
            fetchDogsFromCoreData()
        }
        tableView.reloadData()
    }
    

    
    // use the App Delegate's Context to get the dogs saved to Core Data
    func fetchDogsFromCoreData() {
        do {
            savedDogs = try context.fetch(Dog.fetchRequest())
        } catch {
            print("Fetching Dogs from Core Data failed :( ")
        }
    }
    

}
