//
//  ListingCell.swift
//  Buxury
//
//  Created by Chunyou Su on 11/27/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import Foundation
import UIKit

class ListingCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        
        self.textLabel?.frame = CGRect(x: 280, y: 0, width:self.frame.width - 30, height: 200)
    }
    
}
