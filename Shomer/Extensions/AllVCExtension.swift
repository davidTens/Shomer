//
//  AllVCExtension.swift
//  Shomer
//
//  Created by David T on 5/12/21.
//

import UIKit

extension AllViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? passwords.count : notes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 90 : 90
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerSetup(section: section)
        return section == 0 ? header0 : header1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForHeader0) as! CustomTableViewCell
            cell.titleLabel.text = passwords[indexPath.row].account
            cell.subTitle.text = passwords[indexPath.row].password
            let color = UIView()
            color.backgroundColor = .clear
            cell.selectedBackgroundView = color
            cell.accessoryView = cell.copyImageView
            
            cell.presentAlert = { [weak self] message in
                guard let self = self else { return }
                self.presentAlert(message)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForHeader1) as! NotesTableViewCell
            cell.titleLabel.text = notes[indexPath.row].title
            cell.subTitle.text = notes[indexPath.row].text
            let color = UIView()
            color.backgroundColor = .clear
            cell.selectedBackgroundView = color
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let savedPassword = PasswordsVC()
            savedPassword.passwordId = passwords[indexPath.row]
            savedPassword.modalPresentationStyle = .popover
            present(savedPassword, animated: true, completion: nil)
        } else {
            let savedPassword = NotesVC()
            savedPassword.noteId = notes[indexPath.row]
            savedPassword.modalPresentationStyle = .popover
            present(savedPassword, animated: true, completion: nil)
        }
    }
}
