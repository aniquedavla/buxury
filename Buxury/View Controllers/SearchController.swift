//
//  SearchController.swift
//  Buxury
//
//  Created by Anique Davla on 11/23/1ß.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//
import Foundation
import UIKit
import FirebaseStorage
import FirebaseAuth
//import FirebaseAuth

class SearchController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var row: Int?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "sCell", for: indexPath) as! SearchCell
        
        myCell.imageView?.image = imgArray[indexPath.row]
        myCell.textLabel?.text = "Details ->"
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("selected row = " + String(indexPath.row))
        row = indexPath.row
    }
    
    var imgArray: [UIImage] = []
    var idArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        //getPic()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPic()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imgArray.removeAll()
        idArray.removeAll()
    }
    
    func getPic() {
        //let userID = Auth.auth().currentUser?.uid
        let rImageRef = Storage.storage().reference().child("sofa/All")
        
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
                            self.imgArray.append(temptImg!)
                            self.table.reloadData()
                        }
                    }
                }
            }
        }
        
    }
}
