//
//  ImageFindViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/14/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit

class ImageFindViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var imageOfClickedPhoto: UIView!
    
    @IBOutlet weak var imageFromCamera: UIImageView!
    
    @IBAction func buttonToCallCamera(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.camera
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let imageone = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        imageFromCamera.image = imageone
        let imageTwo = imageone
       
        // print out the image size as a test
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  let visionApi = VisionAPI()
        let imagethree = UIImage(named: "vrkIj")
        let base64String = convertImageTobase64(format: .png, image: imagethree!)
      //  print(base64String)
        let visionApi = VisionAPI()
        
        visionApi.fetchVisionCall(contentone: base64String!){(results:visionapiresponse) in
            
            print(results.responses[0].textAnnotations[0].description)
        }
    }
    
    
    public enum ImageFormat {
        case png
        case jpeg(CGFloat)
    }
    
    
    func convertImageTobase64(format: ImageFormat, image:UIImage) -> String? {
        var imageData: Data?
        
        imageData = image.pngData()
      // case .jpeg(let compression): imageData = UIImageJPEGRepresentation(image, compression)
      
        
        return imageData?.base64EncodedString()
    }
    

   

}
