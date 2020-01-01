//
//  MyListingTableViewController.swift
//  Buxury
//
//  Created by Chunyou Su on 11/27/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import UIKit
import UIKit
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class MyListingTableViewController: UITableViewController {
    
    @IBOutlet weak var myTable: UITableView!
    
    var imageArray: [UIImage] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        self.title = "My listings"
        
        getPic()
        

    }
    
    //get images
    func getPic() {
        let userID = Auth.auth().currentUser?.uid
        let rImageRef = Storage.storage().reference().child("sofa/L" + userID!)
        
        rImageRef.listAll { (result, error) in
            if error != nil {
                print("Error listing all")
            } else {
                print("No error listing all")
                
                for item in result.items {
                    item.getData(maxSize: 50 * 1024 * 1024){ (data, err) in
                        if err != nil {
                            print("error downloading")
                        } else {
                            print("download success")
                            
                            let temptImg = UIImage(data: data!)
                            self.imageArray.append(temptImg!)
                            self.myTable.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListingCell
        
        myCell.imageView?.image = imageArray[indexPath.row]
        myCell.textLabel?.text = "Details ->"
        return myCell
    }
    
}
