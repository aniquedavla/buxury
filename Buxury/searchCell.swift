//
//  searchCell.swift
//  Buxury
//
//  Created by Chunyou Su on 11/28/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var cart: UIButton!
    
    let metadata = StorageMetadata()
    let identifier = UUID().uuidString
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        
        self.textLabel?.frame = CGRect(x: 280, y: 0, width:self.frame.width - 30, height: 200)
    }
    
    @IBAction func toCart(_ sender: Any) {
        let storageRef = Storage.storage().reference()
        metadata.contentType = "image/jpeg"
        var refID: String?
        
        let userID = Auth.auth().currentUser?.uid
        let uploadRef = storageRef.child("sofa/C" + userID! + "/" + identifier)
        
        if cart.currentImage == (#imageLiteral(resourceName: "icons8-favorite-cart-100-2")) {
            cart.setImage(#imageLiteral(resourceName: "icons8-favorite-cart-100"), for: UIControl.State.normal)
            uploadRef.getMetadata { metadata, error in
                if let error = error {
                    if let imageData = self.imageView?.image!.jpegData(compressionQuality: 1) {
                        uploadRef.putData(imageData, metadata: self.metadata, completion: {(metadata, error) in
                            if error != nil {
                                print(error)
                                return
                                
                            }
                            //refID = uploadRef
                            print(uploadRef.name)
                            //print(metadata)
                        })
                        
                    }
                } else {
                    print("exist")
                }
            
            }
    
        } else {
            cart.setImage(#imageLiteral(resourceName: "icons8-favorite-cart-100-2"), for: UIControl.State.normal)
            
            uploadRef.delete()
        }
    
    }
    
    
}
