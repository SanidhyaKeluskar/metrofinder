//
//  FavouriteLandmarksViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/11/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FavouriteLandmarksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
var workoutstwo = PersistenceManager.sharedInstance.fetchWorkouts()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        landmarkNames.removeAll()
        landmarkImages.removeAll()
        for value in workoutstwo{
            landmarkNames.append(value.name)
            landmarkImages.append(value.url)
        }
        
        for value in landmarkNames {
            print(value)
        }
        for value in landmarkImages {
            print(value)
        }
        tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        workoutstwo = PersistenceManager.sharedInstance.fetchWorkouts()
        super.viewWillAppear(animated)
        print("hiiiii")
        
        tableView.reloadData()
        
    }
    

}

extension FavouriteLandmarksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutstwo.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell") as! FavouriteTableViewCell
        
        var decodeme = workoutstwo[indexPath.row].name
        print(decodeme)
        
        cell.nameOfFavourite?.text = workoutstwo[indexPath.row].name
        
        Alamofire.request(workoutstwo[indexPath.row].url).responseImage(completionHandler: { response in
            
            if var image = response.result.value{
                DispatchQueue.main.async {
                    cell.imageOfFavourite?.image = image
                }
                
            }
            
        } )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
        performSegue(withIdentifier: "SegueFive", sender: self)
    }
    
    
}

