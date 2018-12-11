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
var landmarkImages = [String]()
var check = ""

class YelpTableViewController: UITableViewController {
    
    let cellID="CellID"
    let yelapi=YelpAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Landmarks Nearby"
        navigationController?.navigationBar.prefersLargeTitles=true
        landmarkNames.removeAll()
        landmarkImages.removeAll()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        SVProgressHUD.show(withStatus: "Loading")
        if check != stationNames[myindex] {
            check = stationNames[myindex] 
            callyelp()
        }
      
    }
    
    func callyelp(){
        yelapi.fetchlandmarks(selectedStationName: stationNames[myindex]){(results:yelpres) in
            
            for value in results.businesses{
                landmarkNames.append(value.name!)
                landmarkImages.append(value.image_url!)
            }
            for name in landmarkNames{
                
                print(name)
            }

            
            
            SVProgressHUD.dismiss()
            DispatchQueue.main.async{
                self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
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
       
        return landmarkNames.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
        performSegue(withIdentifier: "seguetolast", sender: self)
    }

}
