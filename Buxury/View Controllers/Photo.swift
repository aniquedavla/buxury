/**
* Copyright (c) 2019 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
* distribute, sublicense, create a derivative work, and/or sell copies of the
* Software in any work that is designed, intended, or marketed for pedagogical or
* instructional purposes related to programming, coding, application development,
* or information technology.  Permission for such use, copying, modification,
* merger, publication, distribution, sublicensing, creation of derivative works,
* or sale is expressly withheld.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import Firebase

struct Photo: Hashable {

  var image: UIImage
  init(image:UIImage){
    self.image = image}
  
  init?(dictionary: [String: String]) {
    guard

      let photo = dictionary["Photo"],
      let image = UIImage(named: photo)
      else {
        return nil
    }
    self.init(image:image)
    }

  static func allPhotos() -> [Photo] {
    var photos: [Photo] = []
    guard
      let URL = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
      let photosFromPlist = NSArray(contentsOf: URL) as? [[String:String]]
      else {
        return photos
    }
    for dictionary in photosFromPlist {
      if let photo = Photo(dictionary: dictionary) {
        photos.append(photo)
      }
    }
    return photos
  }
    
    static func getPhotos() -> [Photo] {
        var photos: [Photo] = []
        photos.append(Photo(image: UIImage(named: "blue table")!))
        photos.append(Photo(image: UIImage(named: "gold table")!))
        photos.append(Photo(image: UIImage(named: "white couch")!))
        photos.append(Photo(image: UIImage(named: "white couch 2")!))
        photos.append(Photo(image: UIImage(named: "white sofa 3")!))
        photos.append(Photo(image: UIImage(named: "green chair")!))
        photos.append(Photo(image: UIImage(named: "green chair 1")!))
        photos.append(Photo(image: UIImage(named: "microwave")!))
        photos.append(Photo(image: UIImage(named: "tea ceramics")!))
        photos.append(Photo(image: UIImage(named: "wood console")!))
        photos.append(Photo(image: UIImage(named: "black chair")!))
        photos.append(Photo(image: UIImage(named: "brown chair")!))
        photos.append(Photo(image: UIImage(named: "dining table")!))
        
        return photos
    }
    
    static func getDict(_ photos: [Photo]) -> [Photo: String] {
        let names = ["blue table", "gold table", "white couch", "white couch 2",
        "white sofa 3", "green chair", "green chair 1", "microwave", "tea ceramics", "wood console", "black chair",
         "brown chair", "dining table" ]
        
        return Dictionary(uniqueKeysWithValues: zip(photos, names));
        
    }
}
