//
//  Image.swift
//  UnSplash
//
//  Created by Mutee Ur Rehman on 20/11/2021.
//

import Foundation

struct Image: Codable {
    var id: Int
    var url: URL?
    var isFavourite: Bool
    var tag: String
    
    init(id: Int, urlString: String, isFavourite: Bool = false, tag: String = "") {
        self.id = id
        self.url = URL(string: urlString)
        self.isFavourite = isFavourite
        self.tag = tag
    }
}
