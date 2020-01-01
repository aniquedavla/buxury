//
//  AddListingViewController.swift
//  Buxury
//
//  Created by Chunyou Su on 11/27/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class AddListingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var descriptionT: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var img: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    var storageRef = Storage.storage().reference()
    var db = Firestore.firestore()
    
    //var itemID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionT.delegate = self
        price.delegate = self


        // Do any additional setup after loading the view.
    }
    

    @IBAction func addImage(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
        
    }
    
    @IBAction func submit(_ sender: Any) {
        let user = Auth.auth().currentUser
        let userID = user?.uid
        var ref: DocumentReference?
        var itemID: String?
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        if img == nil {
            print("img = nil")
        }
        if img != nil {
            //create listing -> contain image id and description
            ref = db.collection("listings").document(userID!).collection("yourListing").addDocument(data: ["Description": "nice sofa", "Price Per Day": "10", "Available Till": "2019-12-30"] ) { err in
                if err != nil {
                    print("Error adding document")
                } else {
                    print("Document ID = " + ref!.documentID)
                    itemID = ref!.documentID
                    print("item id = " + itemID!)
                    print("L" + userID! + "/" + itemID!)
                    
                    let uploadRef = self.storageRef.child("sofa/L" + userID! + "/" + itemID! + ".jpg")
                    
                    if let imageData = self.img.image?.jpegData(compressionQuality: 1) {
                        uploadRef.putData(imageData, metadata: metadata, completion: {(metadata, error) in
                            if error != nil {
                                print(error)
                                return
                                
                            }
                            print(metadata)
                        })
                        
                    }
                    
                    let allRef = self.storageRef.child("sofa/All" + "/" + itemID!)
                    
                    if let imageData = self.img.image?.jpegData(compressionQuality: 1) {
                        allRef.putData(imageData, metadata: metadata, completion: {(metadata, error) in
                            if error != nil {
                                print(error)
                                return
                                
                            }
                            print(metadata)
                        })
                        
                    }
                    
                }
            }
            
        }
        
        // image.pngData(img.image!, 1)
            
        //let uploadRef = storageRef.child("L" + userID! + "/" + itemID!)
        //let upLoadTask = uploadRef.putData(imageData, metadata: nil) { (metadata, error) in
            //guard let metadata = metadata else {
                //print("Error uploading")
              // return
           // }

      //  }
    }
        
        
//
//        ref = db.collection("users").document(userID!)
//        ref?.getDocument { (document, error) in
//            if let document = document, document.exists {
//                var dataDescription = document.data().map(String.init(describing: )) ?? "nil"
//                let unwantedChar:Set<Character> = ["[", ":", "]", "\""]
//                dataDescription.removeAll(where: {unwantedChar.contains($0)})
//                print(dataDescription)
//            } else {
//                print("Document does not exist")
//            }
//        }
        
        

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true)
        img.image = info[.originalImage] as? UIImage
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

