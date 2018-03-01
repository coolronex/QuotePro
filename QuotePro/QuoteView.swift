//
//  QuoteView.swift
//  QuotePro
//
//  Created by Aaron Chong on 2/28/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

import UIKit

class QuoteView: UIView {

    @IBOutlet var contentView: QuoteView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("QuoteView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
}
