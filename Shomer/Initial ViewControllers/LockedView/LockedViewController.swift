//
//  LockedViewController.swift
//  Shomer
//
//  Created by David T on 4/30/21.
//

import UIKit
import CoreData

final class LockedViewController: UIViewController {
    
    let presenter = LockedViewPresenter()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.lockedViewDelegate = self
        navigationController?.setNavigationBarHidden(true, animated: true)
        interface()
    }
    
    @objc private func loginClicked() {
        presenter.checkUserValidity()
    }
    
    @objc private func newClicked() {
        let alertSheet = UIAlertController(title: "New", message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "Password", style: .default) { [weak self] _ in
            let addNewVC = AddNewPasswordTableViewController()
            addNewVC.modalPresentationStyle = .popover
            self?.present(addNewVC, animated: true, completion: nil)
        }
        let action1 = UIAlertAction(title: "Note", style: .default) { [weak self] _ in
            let addNewVC = AddNewNoteViewController()
            addNewVC.modalPresentationStyle = .popover
            self?.present(addNewVC, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        alertSheet.addAction(action0)
        alertSheet.addAction(action1)
        alertSheet.addAction(cancel)
        present(alertSheet, animated: true, completion: nil)
    }
    
    @objc private func eraseAllPressed() {
        if UserDefaults.standard.passwordEnabledToEraseAll() == true {
            passwordToDeleteAll()
        } else {
            presentAlertToEraseAll()
        }
    }
    
    private func interface() {
        
        view.backgroundColor = UIColor(hexFromString: "#1F2639")
        [loginButton, eraseAllButton, newButton].forEach({ $0.backgroundColor = UIColor(hexFromString: "#39435F") })
        [loginButton, eraseAllButton, newButton].forEach({ $0.setTitleColor(.white, for: .normal) })
        [imageView, loginButton, eraseAllButton, newButton].forEach({ view.addSubview($0) })
        
        imageView.layout(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 160, left: 87, bottom: 0, right: 87), size: .init(width: 0, height: 128))
        loginButton.layout(top: imageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 85, bottom: 0, right: 85), size: .init(width: 0, height: 50))
        eraseAllButton.layout(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.centerXAnchor, padding: .init(top: 0, left: 12, bottom: 20, right: 6), size: .init(width: 0, height: 50))
        newButton.layout(top: nil, leading: view.centerXAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 6, bottom: 20, right: 12), size: .init(width: 0, height: 50))
    }
    
}
