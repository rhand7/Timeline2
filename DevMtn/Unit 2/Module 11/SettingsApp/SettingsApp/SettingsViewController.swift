//
//  SettingsViewController.swift
//  SettingsApp
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self      //self
        tableView.dataSource = self
    }

}

// MARK: Tableview Delegate

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsController.shared.mySettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingUITableViewCell
        
        // Update our cell - first implement our TableViewCell
        
        let setting = SettingsController.shared.mySettings[indexPath.row]  //create setting constant
        cell?.setting = setting                                           //bring in our setting 
        cell?.delegate = self  //5. Delegate is set to self, which is an instance of SettingsVC 
        
        return cell ?? UITableViewCell()
    }
    
}

extension SettingsViewController: SettingsTableViewCellDelegate {     //4. Conform to delegate protocol 
    
    func settingValueChange(_ cell: SettingUITableViewCell, isSelected: Bool) { // Cell is equal to SettingTableViewCell
        guard let setting = cell.setting,
            let cellIndexPath = tableView.indexPath(for: cell) else { return } //7. set cellIndexPath
        
        tableView.beginUpdates()
        setting.isSet = isSelected  //8. this comes from the value in SettingTableViewCell - update when selected
        
        tableView.reloadRows(at: [cellIndexPath], with: .automatic)  //9. reason why we set indexPath
        tableView.endUpdates() //10. endUpdates
        }
    }

