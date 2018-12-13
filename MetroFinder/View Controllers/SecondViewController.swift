//
//  SecondViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/6/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit

var myindex=0
var stationNames = [String]()
var stationLat = [Double]()
var stationLong = [Double]()

class SecondViewController: UITableViewController {
    let wmata=WmataAPI()
    
    let cellID="CellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title="Metro Stations"
        navigationController?.navigationBar.prefersLargeTitles=true
 
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
     
        stationNames.removeAll()
        stationLat.removeAll()
        stationLong.removeAll()
        
        wmata.fetchMetroStations(){(results:SomeThing) in
            for value in results.Stations{
                stationNames.append(value.Name!)
                stationLat.append(value.Lat!)
                stationLong.append(value.Lon!)
                
            }
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            
            for name in stationNames{
                
                print(name)
            }
            
        }
   
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationNames.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let name=stationNames[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
        performSegue(withIdentifier: "segueseven", sender: self)
    }



}
