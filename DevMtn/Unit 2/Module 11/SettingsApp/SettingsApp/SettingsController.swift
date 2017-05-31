//
//  SettingsController.swift
//  SettingsApp
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class SettingsController {
    
    static let shared = SettingsController()                                   //Singleton: Shared Instance Property
    
    var mySettings: [Setting]                                                 //mySettings = array of Settings
    
    init() {
        let music = Setting(name: "Music", image: #imageLiteral(resourceName: "music_screenshot"), isSet: false)
        let apps = Setting(name: "Apps", image: #imageLiteral(resourceName: "app_screenshot"), isSet: true)   //isSet: true just for example (switch On)
        let books = Setting(name: "Books", image: #imageLiteral(resourceName: "book_screenshot"), isSet: false)
        let updates = Setting(name: "Updates", image: #imageLiteral(resourceName: "app_screenshot"), isSet: false)
        
        mySettings = [music, apps, books, updates]                            //initializing mySettings data
    }
}
