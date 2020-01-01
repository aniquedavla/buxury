//
//  ConfirmationViewController.swift
//  Buxury
//
//  Created by Mohamed Albgal on 11/28/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backHome(_ sender: Any) {
        presentingViewController!.dismiss(animated: true) {
            print("done");
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
