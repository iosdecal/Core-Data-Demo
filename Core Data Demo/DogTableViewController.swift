//
//  DogTableViewController.swift
//  Core Data Demo
//
//  Created by Paige Plander on 3/4/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

/// Controller for the view containing a table view listing all of our saved dogs
class DogTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var savedDogs: [CoreDataDog] = []

    @IBOutlet weak var dogTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        dogTableView.delegate = self
        dogTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        // populate the savedDogs array with the Dog objects saved in core data
        fetchDogsFromCoreData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// Let Xcode know how many table view cells should be created
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedDogs.count
    }

    /// Cutomize each cell with each saved dog's attributes
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = dogTableView.dequeueReusableCell(withIdentifier: "dogCell") as? DogTableViewCell {
			// TODO: Setup dog cell.
            cell.dogImageView.image = UIImage(named: "") ?? UIImage(named: "default")
            cell.isUserInteractionEnabled = true
            return cell
        }
        return UITableViewCell()
    }

    /// Allows user to delete dogs from the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			// TODO: delete dog.
            // now that we've deleted a dog, need to update the savedDogs array again
//            fetchDogsFromCoreData()
        }
        tableView.reloadData()
    }

    /// Uses the App Delegate's Context to get the dogs saved to Core Data
    func fetchDogsFromCoreData() {
		// TODO: Fetch dogs.
    }

}
