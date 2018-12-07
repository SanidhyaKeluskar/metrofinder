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
    let cellID="CellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title="Metro Stations"
        navigationController?.navigationBar.prefersLargeTitles=true

       tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
      //  var namesofStation: [String]
        wmata.fetchMetroStations()
       
     //  for name in namesofStation{
    //       print(name)
    //  }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text="HI THERE"
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
