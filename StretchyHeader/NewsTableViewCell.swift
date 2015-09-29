//
//  NewsTableViewCell.swift
//  StretchyHeader
//
//  Created by Alp Eren Can on 29/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    var newsItem: NewsItem? {
        didSet {
            setup()
        }
    }

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    
    func setup() {
        if let item = newsItem {
            switch item.category {
            case .World:
                categoryLabel.textColor = UIColor.greenColor()
            case .Americas:
                categoryLabel.textColor = UIColor.blueColor()
            case .Europe:
                categoryLabel.textColor = UIColor.purpleColor()
            case .MiddleEast:
                categoryLabel.textColor = UIColor.lightGrayColor()
            case .Africa:
                categoryLabel.textColor = UIColor.brownColor()
            case .AsiaPasific:
                categoryLabel.textColor = UIColor.redColor()
            }
            categoryLabel.text = item.category.description()
            headlineLabel.text = item.headline
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
