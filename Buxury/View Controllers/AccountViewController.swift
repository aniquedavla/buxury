//
//  AccountViewController.swift
//  BuxuryAnique
//
//  Created by Anique Davla on 11/16/19.
//  Copyright © 2019 Anique. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth


class AccountViewController: UIViewController {
    
    @IBOutlet weak var displayNameLabel: UILabel!
    var userObj: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = Auth.auth().currentUser
        if let user = currentUser {
            let uID = user.uid as! String
            let email = user.email as! String
            //let use = user.displayName as! String
            print(uID, email)
            //userObj = User(firstName, "empty", email, uID)
            //set the user display name to the user logged in.
            //displayNameLabel.text = userObj.userName
            displayNameLabel.text = email
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        try! Auth.auth().signOut()
        
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.signInViewController) as? LoginViewController
        
        self.view.window?.rootViewController = loginViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    

}
