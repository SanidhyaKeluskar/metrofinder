//
//  LandmarkViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/9/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit

class LandmarkViewController: UIViewController{

    @IBOutlet weak var imageOflandmark: UIImageView!
    @IBOutlet weak var nameofLandmark: UILabel!
    
    @IBOutlet weak var phoneNumberofLandmark: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          nameofLandmark.text=landmarkNames[myindex]
        
    }
    

   

}
