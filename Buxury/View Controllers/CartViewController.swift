//
//  CartViewController.swift
//  Buxury
//
//  Created by Chunyou Su on 11/28/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartCell
        
        myCell.imageView?.image = imageArray[indexPath.row]
        myCell.textLabel?.text = "description...................."
        return myCell
    }
    
    

    var imageArray: [UIImage] = []
    var idArray: [String] = []
    
    var storageRef = Storage.storage().reference()
    
    var userID = Auth.auth().currentUser?.uid
    
    let metadata = StorageMetadata()
    
    let alert = UIAlertController(title: "Purchase completed", message: "", preferredStyle: .actionSheet)
    
    @IBOutlet weak var infoText: UILabel!
    
    
    @IBOutlet weak var cartItems: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        metadata.contentType = "image/jpeg"
        
        cartItems.delegate = self
        cartItems.dataSource = self
        
        getPic()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkOut(_ sender: Any) {
        print("CHECK OUT")
        
        var index = 0
        
        for item in idArray {
            let cartRef = self.storageRef.child("sofa/C" + userID! + "/" + idArray[index])
            index = index + 1
            
            cartRef.delete()
        }
        
        index = 0
        
        for item in imageArray {
            let uploadRef = self.storageRef.child("sofa/R" + userID! + "/" + idArray[index] + ".jpg")
            
            index = index + 1
            
            let imageData = item.jpegData(compressionQuality: 1)
            uploadRef.putData(imageData!, metadata: metadata, completion: {(metadata, error) in
                if error != nil {
                    print(error)
                    
                    return
                    
                }
            })
            
        }
    }
    
    func getPic() {
        let userID = Auth.auth().currentUser?.uid
        let rImageRef = Storage.storage().reference().child("sofa/C" + userID!)
        
        rImageRef.listAll { (result, error) in
            if error != nil {
                print("Error listing all")
            } else {
                print("No error listing all")
                
                for item in result.items {
                    self.idArray.append(item.name)
                    item.getData(maxSize: 50 * 1024 * 1024){ (data, err) in
                        if err != nil {
                            print("error downloading")
                        } else {
                            print("download success")
                            
                            let temptImg = UIImage(data: data!)
                            self.imageArray.append(temptImg!)
                            self.cartItems.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
    
}
