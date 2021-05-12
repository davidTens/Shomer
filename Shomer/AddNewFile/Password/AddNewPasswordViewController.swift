//
//  AddNewViewController.swift
//  Shomer
//
//  Created by David T on 4/30/21.
//

import UIKit

final class AddNewPasswordTableViewController: UITableViewController {
    
    let cellId = "cellId"
    lazy var headerView = UIView()
    let headerHeight: CGFloat = 370.0
    let cellHeight: CGFloat = 55
    private let textFieldHeight: CGFloat = 50
    private let textFieldLRPadding: CGFloat = 20
    private let gradientColors = [UIColor(hexFromString: "#262D40").cgColor, UIColor(hexFromString: "#34406C").cgColor]
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var appTextField = AppTextField()
    private lazy var accountTextField = AccountTextField()
    private lazy var passwordTextField = PasswordTextField()
    private lazy var appBottomLine = AppBottomLine()
    private lazy var accountBottomLine = AccountBottomLine()
    private lazy var passwordBottomLine = PasswordBottomLine()
    private lazy var backgroundGradient = ViewControllerBackgruondGradient()
    private lazy var gradientLayer = ViewControllerGradientLayer(layer: CALayer())
    private lazy var buttonsBackground = ButtonsBackground()
    private lazy var verticalLine = VerticalLine()
    private lazy var cancelButton = CancelButton()
    private lazy var saveButton = SaveButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(hexFromString: "#273250")
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        appTextField.becomeFirstResponder()
        headerSetUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = backgroundGradient.bounds
    }
    
    fileprivate func headerSetUp() {
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.layer.masksToBounds = false
        headerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        headerView.layer.shadowOffset = CGSize(width: 0, height: 3.5)
        headerView.layer.shadowRadius = 5.0
        headerView.layer.shadowOpacity = 1.0
        view.addSubview(headerView)
        
        headerView.backgroundColor = .clear
        
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        headerView.addSubview(backgroundGradient)
        backgroundGradient.fillSuperview()
        backgroundGradient.layer.insertSublayer(gradientLayer, at: 0)
        
        headerInterfaceStyle()
        
        backgroundGradient.addSubview(buttonsBackground)
        buttonsBackground.addSubview(verticalLine)
    
        buttonsBackground.layout(top: nil, leading: backgroundGradient.safeAreaLayoutGuide.leadingAnchor, bottom: backgroundGradient.bottomAnchor, trailing: backgroundGradient.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 85, bottom: 0, right: 85), size: .init(width: 0, height: 50))
        verticalLine.xyAnchors(x: buttonsBackground.centerXAnchor, y: buttonsBackground.centerYAnchor, size: .init(width: 1, height: 30))
        
        let stackView = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        buttonsBackground.addSubview(stackView)
        stackView.fillSuperview()
        cancelButton.addTarget(self, action: #selector(cancelClicked), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
    }
    
    private func headerInterfaceStyle() {
        
        [appTextField, accountTextField, passwordTextField].forEach({ headerView.addSubview($0) })
        
        [appBottomLine, accountBottomLine, passwordBottomLine].forEach({ line in
            line.backgroundColor = #colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 0.7880730029)
            line.layer.cornerRadius = 2
            headerView.addSubview(line)
    })
        
        appTextField.layout(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 50, left: textFieldLRPadding, bottom: 0, right: textFieldLRPadding), size: .init(width: 0, height: textFieldHeight))
        accountTextField.layout(top: appTextField.bottomAnchor, leading: appTextField.leadingAnchor, bottom: nil, trailing: appTextField.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: textFieldHeight))
        passwordTextField.layout(top: accountTextField.bottomAnchor, leading: appTextField.leadingAnchor, bottom: nil, trailing: appTextField.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: textFieldHeight))
        appBottomLine.layout(top: nil, leading: appTextField.leadingAnchor, bottom: appTextField.bottomAnchor, trailing: appTextField.trailingAnchor, padding: .init(top: 1, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        accountBottomLine.layout(top: nil, leading: accountTextField.leadingAnchor, bottom: accountTextField.bottomAnchor, trailing: accountTextField.trailingAnchor, padding: .init(top: 1, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        passwordBottomLine.layout(top: nil, leading: passwordTextField.leadingAnchor, bottom: passwordTextField.bottomAnchor, trailing: passwordTextField.trailingAnchor, padding: .init(top: 1, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
    }
    
    @objc private func saveClicked() {
        if accountTextField.text?.isEmpty == true {
            accountBottomLine.backgroundColor = .red
        } else {
            accountBottomLine.backgroundColor = .white
        }
        if passwordTextField.text?.isEmpty == true {
            passwordBottomLine.backgroundColor = .red
        } else {
            passwordBottomLine.backgroundColor = .white
        }
        if accountTextField.text != "" && passwordTextField.text != "" {
            let newPassword = Passwords(context: context)
            newPassword.app = appTextField.text
            newPassword.account = accountTextField.text
            newPassword.password = passwordTextField.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss E, d MMM y"
            newPassword.date = "Created on \(dateFormatter.string(from: Date()))"
            
            do {
                try context.save()
                NotificationCenter.default.post(name: .updatePasswordsViewController, object: nil)
                dismiss(animated: true, completion: nil)
            }
            
            catch { print("could not save") }
        }
    }
    
    @objc private func cancelClicked() {
        dismiss(animated: true, completion: nil)
    }
}
