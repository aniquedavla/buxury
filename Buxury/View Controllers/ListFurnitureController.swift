//
//  RentFurnitureController.swift
//  BuxuryAnique
//
//  Created by Anique Davla on 11/16/19.
//  Copyright © 2019 Anique. All rights reserved.
//

import Foundation
import Eureka
import ImageRow
import SwiftyJSON
import FirebaseDatabase
import Firebase
import FirebaseStorage

class ListFurnitureController: FormViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var formData:Dictionary! = [:]
    var emptyFormData:Dictionary! = [:]
    var ref: DatabaseReference!
    var userID: String = ""
    var fireStoreRef: DocumentReference? = nil
    //var db: Firestore!
    var imagePicker: UIImagePickerController!

    @IBOutlet weak var img: UIImageView!
    var storageRef = Storage.storage().reference()
    var db = Firestore.firestore()
    
//    @IBAction func rentItOutPressed(_ sender: UIButton) {
//        print("button pressed!")
//        //print(formValues["type"], separator: "Data: ", terminator: "End of Data")
////        formData = NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding.rawValue)! as String
////
//
//    }

    @IBAction func addImage(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        addFurnitureForm()
        emptyFormData = form.values()
        //ref = Database.database().reference()
        db = Firestore.firestore()
    }

    func addFurnitureForm(){
        form +++
            Section()
            <<< TextRow("type") { row in
                row.title = "Furniture Type"
                row.add(rule: RuleRequired())
            }

            <<< TextRow("color") { row in
                row.title = "Color"
            }

            <<< DecimalRow("pricePerDay") {
                $0.title = "Price/per day"
                $0.value = 0
                $0.formatter = DecimalFormatter()
                $0.useFormatterDuringInput = true
                //$0.useFormatterOnDidBeginEditing = true
                $0.add(rule: RuleRequired())
                }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
                }

            <<< DateRow("availableFrom") {
                $0.value = Date();
                $0.title = "From day"
                $0.add(rule: RuleRequired())
            }

            <<< DateRow("availableTo") {
                $0.value = Date();
                $0.title = "To day"
                $0.add(rule: RuleRequired())
            }

            <<< TextAreaRow("discription") {
                    $0.placeholder = "Discription"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 100)
            }


    }

    @IBAction func rentItOutPressed(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        let userID = user?.uid
        var ref: DocumentReference?
        var itemID: String?
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        formData = form.values() as [String: Any]
        print(formData)
        //let formJson: try JSONSerialization.data(withJSONObject: formData, options: [])
        //add data to firebase

        //convert to unix timestamp for firebase
        var timeFrom = formData["availableFrom"] as! NSDate
        var unixTimeFrom = timeFrom.timeIntervalSince1970;
        var timeTo = formData["availableTo"] as! NSDate
        var unixTimeTo = timeTo.timeIntervalSince1970;

        print(unixTimeFrom, unixTimeTo)
        let type = formData["type"] as! String
        let color = formData["color"] as! String
        let pricePerDay = formData["pricePerDay"] as! Double
        let discription = formData["discription"] as! String

        let listing = Listing(type: type, color: color, pricePerDay: pricePerDay, availableFrom: unixTimeFrom, availableTo: unixTimeTo, discription: discription)

        print(listing)

//        //adds to realtime database
//        ref.child("listings").childByAutoId().setValue([
//                    "type":listing.type,
//                    "color":listing.color,
//                    "pricePerDay": listing.pricePerDay,
//                    "availableFrom": listing.availableFrom,
//                    "availableTo": listing.availableTo,
//                    "discription": listing.discription
//
//                    ]){ (error:Error?, ref:DatabaseReference) in
//                      if let error = error {
//                        print("Data could not be saved: \(error).")
//                      } else {
//                        print("Data saved successfully!")
//                      }
//                    }

        //time_t unixTime = (time_t) [[NSDate date] timeIntervalSince1970];

        if img == nil {
                   print("img = nil")
               }
        if img != nil {
            ref = db.collection("listings").document(userID!).collection("yourListing").addDocument(data:[
                    "type":listing.type,
                    "color":listing.color,
                    "pricePerDay": listing.pricePerDay,
                    "availableFrom": listing.availableFrom,
                    "availableTo": listing.availableTo,
                    "discription": listing.discription
                    ])
                { err in
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
        
//        fireStoreRef = db.collection("listings").addDocument(data: [
//                "type":listing.type,
//                "color":listing.color,
//                "pricePerDay": listing.pricePerDay,
//                "availableFrom": listing.availableFrom,
//                "availableTo": listing.availableTo,
//                "discription": listing.discription
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(self.fireStoreRef!.documentID)")
//            }
//        }
        
        
        
        
        resetFurnitureForm()
        //performSegue(withIdentifier: "yourListings", sender: nil)
    }

    func resetFurnitureForm(){
        form.setValues(emptyFormData as! [String : Any?])
        tableView.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         imagePicker.dismiss(animated: true)
         img.image = info[.originalImage] as? UIImage
     }
}
