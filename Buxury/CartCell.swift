//
//  CartCell.swift
//  Buxury
//
//  Created by Chunyou Su on 11/28/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import Foundation
import UIKit

class CartCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        
        self.textLabel?.frame = CGRect(x: 200, y: 0, width:self.frame.width - 30, height: 100)
    }
    
}
