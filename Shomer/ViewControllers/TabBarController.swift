//
//  TabBarController.swift
//  Shomer
//
//  Created by David T on 4/19/21.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let sidePadding: CGFloat = 28
    private let barHeight: CGFloat = 60
    private let addButtonSize: CGFloat = 62
    
    private let homeButton = UIButton()
    private let passwordsButton = UIButton()
    private let notesButton = UIButton()
    private let settingsButton = UIButton()
    
    private lazy var buttonsArray = [homeButton, passwordsButton, notesButton, settingsButton]
    private lazy var buttonImages = [UIImage(named: "homeImage"), UIImage(named: "passwordImage"), UIImage(named: "noteImage"), UIImage(named: "settingsImage")]
    
    private lazy var customTabBarView: UIVisualEffectView = {
        let customTabBarView = UIVisualEffectView()
        customTabBarView.effect = UIBlurEffect(style: .dark)
        customTabBarView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        customTabBarView.clipsToBounds = true
        customTabBarView.layer.cornerRadius = 30
        return customTabBarView
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        addButton.backgroundColor = UIColor(hexFromString: "#363E5A")
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitleColor(UIColor(hexFromString: "#CCCCCC"), for: .highlighted)
        addButton.titleLabel?.font = UIFont(name: "Avenir", size: 40)
        addButton.layer.cornerRadius = addButtonSize / 2
        addButton.layer.masksToBounds = false
        addButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        addButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        addButton.layer.shadowRadius = 5.0
        addButton.layer.shadowOpacity = 1.0
        return addButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        
        let quickAccessViewController = UINavigationController(rootViewController: AllViewController())
        let passwordsViewController = UINavigationController(rootViewController: PasswordsViewController())
        let noteViewController = UINavigationController(rootViewController: NotesViewController())
        let settingsViewController = UINavigationController(rootViewController: SettingsViewController())
        viewControllers = [quickAccessViewController, passwordsViewController, noteViewController, settingsViewController]
        interfaceSetup()
        tabBarSetup()
        chosenIndex(buttonsArray[selectedIndex])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func tabBarSetup() {
        
        buttonsArray.enumerated().forEach({ index, button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = index
            button.addTarget(self, action: #selector(barButtonsAction(_:)), for: .touchUpInside)
            button.setImage(buttonImages[index]?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = #colorLiteral(red: 0.6064629555, green: 0.6028606296, blue: 0.6092337966, alpha: 1)
            button.isSelected = true
        })
        
        let leftSideStackView = UIStackView(arrangedSubviews: [homeButton, passwordsButton])
        leftSideStackView.axis = .horizontal
        leftSideStackView.distribution = .fillEqually
        
        let rightSideStackView = UIStackView(arrangedSubviews: [notesButton, settingsButton])
        rightSideStackView.axis = .horizontal
        rightSideStackView.distribution = .fillEqually
        
        customTabBarView.contentView.addSubview(leftSideStackView)
        customTabBarView.contentView.addSubview(rightSideStackView)
        
        leftSideStackView.layout(top: customTabBarView.contentView.topAnchor, leading: customTabBarView.contentView.leadingAnchor, bottom: customTabBarView.contentView.bottomAnchor, trailing: addButton.leadingAnchor, padding: .init(top: 0, left: 3, bottom: 0, right: 0))
        rightSideStackView.layout(top: customTabBarView.contentView.topAnchor, leading: addButton.trailingAnchor, bottom: customTabBarView.contentView.bottomAnchor, trailing: customTabBarView.contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 3))
    }
    
    @objc private func barButtonsAction(_ sender: UIButton) {
        
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        if buttonsArray[selectedIndex].isSelected == true {
            buttonsArray[selectedIndex].tintColor = .white
            buttonsArray[previousIndex].tintColor = #colorLiteral(red: 0.6064629555, green: 0.6028606296, blue: 0.6092337966, alpha: 1)
            
            if buttonsArray[selectedIndex] == buttonsArray[previousIndex] {
                buttonsArray[selectedIndex].tintColor = .white
                
                let selectedViewController = viewControllers![selectedIndex] as! UINavigationController
                selectedViewController.popToRootViewController(animated: true)
            }
        }
    }
    
    @objc private func addButtonPressed(_ sender: UIButton) {
        let alertSheet = UIAlertController(title: "New", message: nil, preferredStyle: .actionSheet)
        let passwordsAction = UIAlertAction(title: "Password", style: .default) { [weak self] _  in
            let addNewController = AddNewPasswordTableViewController()
            addNewController.modalPresentationStyle = .popover
            self?.present(addNewController, animated: true, completion: nil)
        }
        let notesAction = UIAlertAction(title: "Note", style: .default) { [weak self] _ in
            let noteViewController = AddNewNoteViewController()
            noteViewController.modalPresentationStyle = .popover
            self?.present(noteViewController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        alertSheet.addAction(passwordsAction)
        alertSheet.addAction(notesAction)
        alertSheet.addAction(cancel)
        present(alertSheet, animated: true, completion: nil)
    }
    
    private func chosenIndex(_ sender: UIButton) {
        sender.tintColor = .white
    }
    
    @objc private func applicationWillResignActive() {
        dismiss(animated: false, completion: nil)
    }
    
    private func interfaceSetup() {
        
        view.addSubview(customTabBarView)
        view.addSubview(addButton)
        
        customTabBarView.layout(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: sidePadding, bottom: 12, right: sidePadding), size: .init(width: 0, height: barHeight))
        addButton.xyAnchors(x: customTabBarView.contentView.centerXAnchor, y: customTabBarView.contentView.centerYAnchor, size: .init(width: addButtonSize, height: addButtonSize), yPadding: -15)
        
    }
}
