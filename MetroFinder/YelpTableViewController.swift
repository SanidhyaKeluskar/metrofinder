//
//  YelpTableViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/8/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit
import SVProgressHUD

var landmarkNames = [String]()
class YelpTableViewController: UITableViewController {
    
    let cellID="CellID"
    let yelapi=YelpAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Landmarks Nearby"
        navigationController?.navigationBar.prefersLargeTitles=true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        SVProgressHUD.show(withStatus: "Loading")
        
        yelapi.fetchlandmarks(selectedStationName: stationNames[myindex]){(results:yelpres) in
            
            for value in results.businesses{
                landmarkNames.append(value.name!)
            }
            
            SVProgressHUD.dismiss()
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let name=landmarkNames[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return landmarkNames.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
        performSegue(withIdentifier: "seguetolast", sender: self)
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
