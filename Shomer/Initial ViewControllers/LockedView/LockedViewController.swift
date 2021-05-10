//
//  LockedViewController.swift
//  Shomer
//
//  Created by David T on 4/30/21.
//

import UIKit
import CoreData

final class LockedViewController: UIViewController, LockedViewDelegate {
    
    deinit {
        print("we are gucci")
    }
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shomerLogo")?.withRenderingMode(.alwaysTemplate)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Menlo", size: 19)
        loginButton.layer.cornerRadius = 5
        return loginButton
    }()
    
    private lazy var eraseAllButton: UIButton = {
        let eraseAllButton = UIButton()
        eraseAllButton.addTarget(self, action: #selector(eraseAllPressed), for: .touchUpInside)
        eraseAllButton.setTitle("erase all", for: .normal)
        eraseAllButton.titleLabel?.font = UIFont(name: "Menlo", size: 17)
        eraseAllButton.layer.cornerRadius = 5
        return eraseAllButton
    }()
    
    private lazy var newButton: UIButton = {
        let newButton = UIButton()
        newButton.addTarget(self, action: #selector(newClicked), for: .touchUpInside)
        newButton.setTitle("+ new", for: .normal)
        newButton.titleLabel?.font = UIFont(name: "Menlo", size: 17)
        newButton.layer.cornerRadius = 5
        return newButton
    }()
    
    let presenter = LockedViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.lockedViewDelegate = self
        navigationController?.setNavigationBarHidden(true, animated: true)
        interface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(hexFromString: "#1F2639")
        [loginButton, eraseAllButton, newButton].forEach({ $0.backgroundColor = UIColor(hexFromString: "#39435F") })
        [loginButton, eraseAllButton, newButton].forEach({ $0.setTitleColor(.white, for: .normal) })
    }
    
    @objc private func loginClicked() {
        presenter.checkUserValidity()
    }
    
    @objc private func newClicked() {
        let addNewVC = AddNewPasswordTableViewController()
        addNewVC.modalPresentationStyle = .popover
        present(addNewVC, animated: true, completion: nil)
    }
    
    @objc private func eraseAllPressed() {
        if UserDefaults.standard.passwordEnabledToEraseAll() == true {
            
        } else {
            
        }
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
    
    private func interface() {
        
        [imageView, loginButton, eraseAllButton, newButton].forEach({ view.addSubview($0) })
        
        imageView.layout(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 160, left: 87, bottom: 0, right: 87), size: .init(width: 0, height: 128))
        loginButton.layout(top: imageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 85, bottom: 0, right: 85), size: .init(width: 0, height: 50))
        eraseAllButton.layout(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.centerXAnchor, padding: .init(top: 0, left: 12, bottom: 20, right: 6), size: .init(width: 0, height: 50))
        newButton.layout(top: nil, leading: view.centerXAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 6, bottom: 20, right: 12), size: .init(width: 0, height: 50))
        
    }
    
    // MARK: - protocol stubs
    
    func successfulBiometricAuth() {
        let tabbar = TabBarController()
        tabbar.modalPresentationStyle = .fullScreen
        present(tabbar, animated: true, completion: nil)
    }
    
    func unSuccessfulBiometricAuth() {
        let enter = EnterPasswordViewController()
        enter.modalPresentationStyle = .popover
        present(enter, animated: true, completion: nil)
    }
    
    func presentEnterPasswrodVC() {
        let enter = EnterPasswordViewController()
        enter.modalPresentationStyle = .popover
        present(enter, animated: true, completion: nil)
    }
    
    func presentNewPasswordVC() {
        let tabBarVC = NewPasswordViewController()
        tabBarVC.modalPresentationStyle = .popover
        present(tabBarVC, animated: true, completion: nil)
    }
    
    func eraseAll() {
        print("kabboming")
    }
    
    func addNewClicked() {
        presenter.checkUserValidity()
    }
    
}
