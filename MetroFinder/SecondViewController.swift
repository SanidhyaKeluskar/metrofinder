//
//  SecondViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/6/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {
    let wmata=WmataAPI()
    var stationNames = [String]()
    let cellID="CellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title="Metro Stations"
        navigationController?.navigationBar.prefersLargeTitles=true
 
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
     
        wmata.fetchMetroStations(){(results:SomeThing) in
            for value in results.Stations{
                self.stationNames.append(value.Name!)
            }
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            
            for name in self.stationNames{
                
                print(name)
            }
            
        }
   
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationNames.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let name=self.stationNames[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }



}
