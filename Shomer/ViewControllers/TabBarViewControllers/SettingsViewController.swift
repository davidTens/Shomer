//
//  SettingsViewController.swift
//  Shomer
//
//  Created by David T on 4/20/21.
//

import UIKit
import CoreData

final class SettingsViewController: UITableViewController {
    
    lazy var headerViewSecOne = UIView()
    lazy var headerViewSecTwo = UIView()
    
    let cellIdForSwitcher = "cellIdForSwitcher"
    let cellIdForButton = "cellIdForButton"
    let headerHeightForO: CGFloat = 50
    let cellHeight: CGFloat = 50
    let headerHeightForTwo: CGFloat = 30
    
    let settingsListSwitcher = ["Biometric Auth", "Require password to erase all", "Make passwords visible"]
    let settingsListButtons = ["Change password", "Erase all", "Log out"]
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var backgroundGradient = ViewControllerBackgruondGradient()
    private lazy var gradientLayer = ViewControllerGradientLayer(layer: CALayer())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: "#2E315A", alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tableView.register(SettingsCell.self, forCellReuseIdentifier: cellIdForSwitcher)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdForButton)
        tableView.addSubview(backgroundGradient)
        backgroundGradient.frame = tableView.frame
        backgroundGradient.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundGradient
        headerInterface()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = backgroundGradient.bounds
    }
    
    private func headerInterface() {
        view.addSubview(headerViewSecOne)
        headerViewSecOne.translatesAutoresizingMaskIntoConstraints = false
        [
            headerViewSecOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerViewSecOne.heightAnchor.constraint(equalToConstant: headerHeightForO),
            headerViewSecOne.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerViewSecOne.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].forEach({ $0.isActive = true })
    }
    
    func eraseAllClicked() {
        let alert = UIAlertController(title: "Erase All", message: "Are you sure you want to erase all?", preferredStyle: .alert)
        let action0 = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        let action1 = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.deleteAll()
        }
        alert.addAction(action0)
        alert.addAction(action1)
        present(alert, animated: true, completion: nil)
    }
    
    func changePasswordClicked() {
        let newPass = NewPasswordViewController()
        newPass.modalPresentationStyle = .popover
        present(newPass, animated: true, completion: nil)
    }
    
    func logoutClicked() {
        let logOut = LockedViewController()
        logOut.modalPresentationStyle = .fullScreen
        present(logOut, animated: true, completion: nil)
    }
    
    func presentAlert(_ message: String) {
        let alert = UIAlertController(title: "Copied to clipboard", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in })
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteAll() {
        
        let deletePasswords = NSBatchDeleteRequest(fetchRequest: Passwords.fetchRequest())
        let deleteNotes = NSBatchDeleteRequest(fetchRequest: Notes.fetchRequest())
        do {
            try context.execute(deletePasswords)
            try context.execute(deleteNotes)
            
        }
        catch {print(error)}
        
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.bioAuth.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.passwordEnabledToEraseAll.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.passwordIsEnabled.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.passwordString.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.visiblePasswords.rawValue)
        
        let lock = LockedViewController()
        lock.modalPresentationStyle = .fullScreen
        present(lock, animated: true, completion: nil)
    }
}
