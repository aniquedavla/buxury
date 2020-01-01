//
//  DetailPageViewController.swift
//  Buxury
//
//  Created by Mohamed Albgal on 11/28/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController {

    
    /*
        create the vars for the ui children
        create the outlets for the ui children
        make the view did load to bind the properties to the ui children's values
     
     ideally, instead of passing properties, pass a "user" item and get all details from the that instance's properties, so that passing along the instance is easier
     **/
    var tempName: String = "Denim Sofa"
    var tempPic: UIImage? = nil //{
//        didSet {
//            setPic()
//        }
//    }
    var tempType: String = "Sofa"
    var tempColor: String = "Blue"
    var tempPrice: String = "$100"
    var tempFromDate: String = "November 10"
    var tempTodate: String = "November 13"
    var tempDescription: String = "If you love the cool look of leather but long for the warm feel of fabric, you’ll find the Bladen sofa fits the bill beautifully. Rest assured, the textural, multi-tonal upholstery is rich with character and interest—while plush, pillowy cushions merge comfort and support with a high-style design."
     
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemType: UILabel!
    @IBOutlet weak var itemColor: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemFromDate: UILabel!
    @IBOutlet weak var itemToDate: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    
    @IBOutlet weak var itemImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemName.text = tempName
        itemType.text = tempType
        itemColor.text = tempColor
        itemPrice.text = tempPrice
        itemFromDate.text = tempFromDate
        itemToDate.text = tempTodate
        itemDescription.text = tempDescription
        if let pic = tempPic{
            itemImage.image = pic;
        }
        
        // Do any additional setup after loading the view.
    }
    
    //func setPic(){ itemImage.image = tempPic}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
