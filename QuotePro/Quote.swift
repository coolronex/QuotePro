//
//  Quote.swift
//  QuotePro
//
//  Created by Aaron Chong on 2/28/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

import UIKit

class Quote: NSObject {

    var quote: String
    var personName: String
    
    init(quote: String, personName: String) {
        
        self.quote = quote
        self.personName = personName
    }
}
