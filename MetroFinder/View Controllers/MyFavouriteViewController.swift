//
//  MyFavouriteViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/11/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MyFavouriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
  var workoutstwo = PersistenceManager.sharedInstance.fetchWorkouts()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title="Favourites"
        navigationController?.navigationBar.prefersLargeTitles=false
        
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

extension MyFavouriteViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  workoutstwo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavouriteLandmark") as! MyFavouriteTableViewCell
        
        cell.myFavouriteLandmarkname.text = workoutstwo[indexPath.row].name
        
        Alamofire.request(workoutstwo[indexPath.row].url).responseImage(completionHandler: { response in
            
            if var image = response.result.value{
                DispatchQueue.main.async {
                    cell.myFavouriteLandmarkImage.image = image
                }
                
            }
            
        } )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
        performSegue(withIdentifier: "segueten", sender: self)
    }
}
