//
//  SettingsVCExtensionn.swift
//  Shomer
//
//  Created by David T on 5/7/21.
//

import UIKit

extension SettingsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? settingsListSwitcher.count : settingsListButtons.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? headerViewSecOne : headerViewSecTwo
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? headerHeightForO : headerHeightForTwo
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForSwitcher, for: indexPath) as! SettingsCell
            cell.titleTextLabel.text = settingsListSwitcher[indexPath.row]
            cell.accessoryView = cell.switcher
            let highlightedColor = UIView()
            highlightedColor.backgroundColor = .clear
            cell.selectedBackgroundView = highlightedColor
            
            if UserDefaults.standard.bioAuthEnabled() == true {
                if settingsListSwitcher[indexPath.row] == "Biometric Auth" {
                    cell.switcher.isOn = true
                }
            }
            if UserDefaults.standard.passwordEnabledToEraseAll() == true {
                if settingsListSwitcher[indexPath.row] == "Require password to erase all" {
                    cell.switcher.isOn = true
                }
            }
            cell.switchValueHandler = { [weak self] switcher in
                guard let self = self else { return }
                
                if self.settingsListSwitcher[indexPath.row] == "Biometric Auth" {
                    if switcher.isOn == true {
                        UserDefaults.standard.setBioAuthEnabled(true)
                    } else {
                        UserDefaults.standard.setBioAuthEnabled(false)
                    }
                }
                if self.settingsListSwitcher[indexPath.row] == "Require password to erase all" {
                    if switcher.isOn == true {
                        UserDefaults.standard.setpasswordEnabledToEraseAll(true)
                    } else  {
                        UserDefaults.standard.setpasswordEnabledToEraseAll(false)
                    }
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForButton, for: indexPath)
            cell.backgroundColor = UIColor(hexFromString: "#333764", alpha: 0.8)
            cell.textLabel?.text = settingsListButtons[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Avenir Bold", size: 16)
            cell.textLabel?.textColor = .white
            let highlightedColor = UIView()
            highlightedColor.backgroundColor = .clear
            cell.selectedBackgroundView = highlightedColor
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if settingsListButtons[indexPath.row] == "Change password" {
                changePasswordClicked()
            }
            if settingsListButtons[indexPath.row] == "Erase all" {
                eraseAllClicked()
            }
            if settingsListButtons[indexPath.row] == "Log out" {
                logoutClicked()
            }
        }
    }
}
