//
//  Setting.swift
//  SettingsApp
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class Setting {
    
    let name: String
    var image: UIImage?
    var isSet: Bool
    
    init(name: String, image: UIImage?, isSet: Bool) {
        self.name = name
        self.image = image
        self.isSet = isSet
    }
}
