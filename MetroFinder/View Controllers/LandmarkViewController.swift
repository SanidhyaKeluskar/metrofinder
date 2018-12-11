//
//  LandmarkViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/9/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class LandmarkViewController: UIViewController{

    @IBOutlet weak var imageOflandmark: UIImageView!
    @IBOutlet weak var nameofLandmark: UILabel!
    @IBOutlet weak var phoneNumberofLandmark: UILabel!
    @IBAction func favourites(_ sender: Any) {
        let workout = FavouriteLandMarkModel(name: landmarkNames[myindex], url: landmarkImages[myindex])
        PersistenceManager.sharedInstance.saveWorkout(workout: workout)

    }
    
    @IBAction func unfavourite(_ sender: Any) {
        PersistenceManager.sharedInstance.remove(name: landmarkNames[myindex])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          nameofLandmark.text=landmarkNames[myindex]
        
        Alamofire.request(landmarkImages[myindex]).responseImage(completionHandler: {response in
            DispatchQueue.main.async {
                self.imageOflandmark.image=response.result.value
            }
        }
        )
       
        
    }
    

   

}
