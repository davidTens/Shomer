//
//  PasswordsVCExtension.swift
//  Shomer
//
//  Created by David T on 5/7/21.
//

import UIKit

extension PasswordsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive && searchController.searchBar.text != "" ? filteredPasswords.count : passwords.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CustomTableViewCell
        let color = UIView()
        color.backgroundColor = .clear
        cell.selectedBackgroundView = color
        cell.accessoryView = cell.copyImageView
        
        cell.presentAlert = { [weak self] message in
            guard let self = self else { return }
            self.presentAlert(message)
        }
        
        let password: Passwords
        if searchController.isActive && searchController.searchBar.text != "" {
            password = filteredPasswords[indexPath.row]
        } else {
            password = passwords[indexPath.row]
        }
        cell.password = password
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            let passwordId = filteredPasswords[indexPath.row]
            popUpPasswordId(passwordId)
        } else {
            let passwordId = passwords[indexPath.row]
            popUpPasswordId(passwordId)
        }
    }
}
