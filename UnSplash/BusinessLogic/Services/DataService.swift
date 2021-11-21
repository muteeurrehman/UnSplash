//
//  DataService.swift
//  UnSplash
//
//  Created by Mutee Ur Rehman on 20/11/2021.
//

import Foundation

class DataService {
    private static var images: [Image]?
    
    class func getImages() -> [Image] {
        
        if let images = self.images {
            return images
        }
        if let data = UserDefaults.standard.value(forKey:UserDefaultKeys.images.rawValue) as? Data {
            if let images = try? PropertyListDecoder().decode(Array<Image>.self, from: data) {
                self.images = images
            }
        }
        return self.images ?? []
    }
    
    class func addToFavourites(id: Int) {
        modifyImageWith(id: id, isFavourite: true, tag: nil)
    }
    class func removeFromFavourites(id: Int) {
        modifyImageWith(id: id, isFavourite: false, tag: nil)
    }
    class func add(tag: String, toImageWith id: Int) {
        modifyImageWith(id: id, isFavourite: nil, tag: tag)
    }
    private class func modifyImageWith(id: Int, isFavourite: Bool? = nil, tag: String? = nil) {
        let images = getImages().map({ (image) -> Image in
            if image.id == id {
                var modifiedImage = image
                if let isFavourite = isFavourite {
                    modifiedImage.isFavourite = isFavourite
                }
                if let tag = tag {
                    modifiedImage.tag = tag
                }
                return modifiedImage
            }
            return image
        })
        
        save(images: images)

    }
    class func save(images: [Image]) {        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(images), forKey:UserDefaultKeys.images.rawValue)
        self.images = images
    }
}
