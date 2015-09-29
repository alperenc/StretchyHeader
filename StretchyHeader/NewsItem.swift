//
//  NewsItem.swift
//  StretchyHeader
//
//  Created by Alp Eren Can on 29/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

enum Category {
    case World, Americas, Europe, MiddleEast, Africa, AsiaPasific
    
    func description() -> String {
        switch self  {
        case .World:
            return "World"
        case .Americas:
            return "Americas"
        case .Europe:
            return "Europe"
        case .MiddleEast:
            return "Middle East"
        case .Africa:
            return "Africa"
        case .AsiaPasific:
            return "Asia Pasific"
        }
        
    }
}

class NewsItem: NSObject {
    
    let category: Category
    let headline: String!
    
    init(category: Category, headline: String) {
        self.category = category
        self.headline = headline
        
        super.init()
    }

}
