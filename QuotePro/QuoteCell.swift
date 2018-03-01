//
//  QuoteCell.swift
//  QuotePro
//
//  Created by Aaron Chong on 2/28/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

import UIKit

class QuoteCell: UITableViewCell {

    @IBOutlet weak var quoteImageView: UIImageView!
    
    var userQuotesPhotos: UserQuotesPhotos! {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureCell() {
        
        quoteImageView.image = userQuotesPhotos.image
    }

}
