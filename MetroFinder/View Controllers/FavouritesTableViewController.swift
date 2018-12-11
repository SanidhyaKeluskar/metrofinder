//
//  FavouritesTableViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/10/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
//let workoutstwo = PersistenceManager.sharedInstance.fetchWorkouts()
var workoutstwo = PersistenceManager.sharedInstance.fetchWorkouts()
    let cellThreeID="CellIDTWOOne"
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellThreeID)
        landmarkNames.removeAll()
        landmarkImages.removeAll()
        for value in workoutstwo{
            landmarkNames.append(value.name)
            landmarkImages.append(value.url)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        workoutstwo = PersistenceManager.sharedInstance.fetchWorkouts()
        super.viewWillAppear(animated) // No need for semicolon
        print("hiiiii")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellThreeID)
        
        tableView.reloadData()
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workoutstwo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellThreeID, for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = String(workoutstwo[indexPath.row].name)
        
        return cell

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
        performSegue(withIdentifier: "SegueFour", sender: self)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
