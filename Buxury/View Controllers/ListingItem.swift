//
//  Listing.swift
//  Buxury
//
//  Created by Mohamed Albgal on 11/28/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import Foundation
import Firebase

class ListingItem {
    
    var db :Firestore!
    init() {
        Firestore.firestore().settings = FirestoreSettings();
        db = Firestore.firestore()
    }
    
    
    
    func getDocument() {
        // [START get_document]
        let docRef = db.collection("listings").document("list-XejuZtbykttCw0sbSzqM")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        // [END get_document]
    }
    
    func getMultipleAll(callback: @escaping (_ objects: [ListingObject])-> Void) {
        // [START get_multiple_all]
        var allItems : [ListingObject] = [];
        db.collection("listings").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dictionary : [String: Any] = document.data()
                    if let obj = ListingObject(dictionary: dictionary) {
                        allItems.append(obj)
                        print(allItems.count)
                    }
                }
                
            }
            callback(allItems)
        }
        
        // [END get_multiple_all]
    }
    

    
    
    struct ListingObject {
        let name: String
        var url: String
        var type: String?
        var color: String?
        var pricePerDay: Double?
        var availableFrom: TimeInterval?
        var availableTo: TimeInterval?
        var discription: String?

        init?(dictionary: [String: Any]) {
            guard let name = dictionary["name"] as? String, let url = dictionary["url"] as? String else { return nil }
            self.name = name
            self.url = url
            self.type = dictionary["type"] as? String
            self.color = dictionary["colro"] as? String
            self.pricePerDay = dictionary["pricePerDay"] as? Double
            self.availableTo = dictionary["availableTo"] as? TimeInterval
            self.availableFrom = dictionary["availableFrom"] as? TimeInterval
            self.discription = dictionary["discription"] as? String
        }
    }
        
}
