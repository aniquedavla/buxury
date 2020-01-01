//
//  CVCell.swift
//  Buxury
//
//  Created by Mohamed Albgal on 11/28/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import UIKit

class CVCell: UICollectionViewCell {
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet private weak var imageView: UIImageView!
      
      override func awakeFromNib() {
        super.awakeFromNib()
        imageContainer.layer.cornerRadius = 6
        imageContainer.layer.masksToBounds = true
      }
      
      var photo: Photo? {
        didSet {
          if let photo = photo {
            imageView.image = photo.image
          }
        }
      }
    }
