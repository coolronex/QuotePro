//
//  UserQuotesPhotos.swift
//  QuotePro
//
//  Created by Aaron Chong on 2/28/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

import UIKit

class UserQuotesPhotos: NSObject {

    var image: Photo
    var quote: Quote
    
    init(image: Photo, quote: Quote) {
        
        self.image = image
        self.quote = quote
    }
}
