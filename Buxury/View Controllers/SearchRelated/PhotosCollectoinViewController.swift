//
//  PhotosViewController.swift
//  bouxery
//
//  Created by Mohamed Albgal on 11/21/19.
//  Copyright © 2019 Mohamed Albgal. All rights reserved.
//


import UIKit
import Firebase
//import SDWebImage


class PhotosCollectionViewController: UICollectionViewController {
//  var photos = Photo.allPhotos()
    let storage = Storage.storage()
    var photos: [Photo]  = Photo.getPhotos();
    var photosHistory : [Photo] = []
    var searchDictionary: [Photo: String] = [:]

    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    searchDictionary =  Photo.getDict(photos);
    
    if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
      layout.delegate = self
    }
    
    if #available(iOS 13.0, *) {
        collectionView?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    } else {
        // Fallback on earlier versions
    }
//    let list = ListingItem();
//    list.getMultipleAll { data in
//        print(data.count, "is the len from within")
//        print(data)
//
//    }

    collectionView?.contentInset = UIEdgeInsets(top: 16, left: 4, bottom: 10, right: 4)
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        if let nc = segue.destination as? UINavigationController, let detailPage = nc.topViewController as? DetailPageViewController, let senderCell = sender as? CVCell {
            let curr_image = senderCell.photo?.image;
            detailPage.tempPic = curr_image
        }
    }
}


extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("in segue")
        self.performSegue(withIdentifier: "detailPage", sender: collectionView.cellForItem(at: indexPath))
//      self.dismiss(animated: false, completion: {
//        print("in segue")
//        self.performSegue(withIdentifier: "detailPage", sender: collectionView.cellForItem(at: indexPath))
//      })
    }
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count

  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CVCell
    cell.photo = photos[indexPath.item]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10))
    return CGSize(width: itemSize, height: itemSize)
  }

}

extension PhotosCollectionViewController: PinterestLayoutDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    return photos[indexPath.item].image.size.height
  }
}

extension PhotosCollectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       //for async, show spinner instead of freeze
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds //?
        activityIndicator.startAnimating()
        filterForSearch(textField.text!)
        //textField.text = nil;
        activityIndicator.removeFromSuperview()
        textField.resignFirstResponder();
        return true;
    }
    
    func filterForSearch(_ term: String){
        if term == "" {
            self.view.layoutIfNeeded()
        }
        let itemsArray = searchDictionary.values;
        let res : [String] = itemsArray.filter({$0.contains(term)});
        print(res)
        var newPhotos : [Photo] = []
        photosHistory = photos;
        for (ph ,str) in searchDictionary {
            if res.contains(str){
                newPhotos.append(ph)
            }
        }
        photos = newPhotos;
        collectionView.reloadData()
    }
}


