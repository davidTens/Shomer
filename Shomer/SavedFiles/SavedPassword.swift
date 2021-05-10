//
//  SavedPassword.swift
//  Shomer
//
//  Created by David T on 5/7/21.
//

import UIKit

final class SavedPassword: UITableViewController {
    
    private let cellId = "cellId"
    private lazy var headerView = UIView()
    private let headerHeight: CGFloat = 370.0
    private let cellHeight: CGFloat = 55
    private let textFieldHeight: CGFloat = 50
    private let textFieldLRPadding: CGFloat = 20
    private let gradientColors = [UIColor(hexFromString: "#262D40").cgColor, UIColor(hexFromString: "#34406C").cgColor]
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var passwordId: Passwords? {
        didSet {
            appTextField.text = passwordId?.app
            accountTextField.text = passwordId?.account
            passwordTextField.text = passwordId?.password
            dateLabel.text = passwordId?.date
        }
    }
    
    private lazy var appTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "app", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#9B9898", alpha: 0.8)])
        textField.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        textField.font = UIFont(name: "Avenir", size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldHeight))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.keyboardAppearance = .dark
        textField.clearButtonMode = .always
        textField.textColor = .white
        textField.layer.cornerRadius = 6
        return textField
    }()
    private lazy var accountTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Account", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#9B9898", alpha: 0.8)])
        textField.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        textField.font = UIFont(name: "Avenir", size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldHeight))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.keyboardAppearance = .dark
        textField.clearButtonMode = .always
        textField.textColor = .white
        textField.layer.cornerRadius = 6
        textField.keyboardType = .emailAddress
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#9B9898", alpha: 0.8)])
        textField.isSecureTextEntry = false
        textField.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        textField.font = UIFont(name: "Avenir", size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldHeight))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.keyboardAppearance = .dark
        textField.clearButtonMode = .always
        textField.textColor = .white
        textField.layer.cornerRadius = 6
        return textField
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "Avenir", size: 18)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.backgroundColor = .clear
        dateLabel.textAlignment = .left
        dateLabel.textColor = .white
        return dateLabel
    }()
    
    private lazy var appBottomLine = UIView()
    private lazy var accountBottomLine = UIView()
    private lazy var passwordBottomLine = UIView()
    
    private lazy var backgroundGradient: UIView = {
        let backgroundGradient = UIView()
        backgroundGradient.backgroundColor = .clear
        return backgroundGradient
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = gradientColors
        return gradientLayer
    }()
    
    private lazy var buttonsBackground: UIView = {
        let buttonsBackground = UIView()
        buttonsBackground.backgroundColor = UIColor(hexFromString: "#3B3B3B", alpha: 0.6)
        buttonsBackground.clipsToBounds = true
        buttonsBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonsBackground.layer.cornerRadius = 13
        return buttonsBackground
    }()
    
    private lazy var verticalLine: UIView = {
        let verticalLine = UIView()
        verticalLine.backgroundColor = UIColor(hexFromString: "#707070")
        return verticalLine
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.addTarget(self, action: #selector(cancelClicked), for: .touchUpInside)
        cancelButton.setTitle("cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.setTitleColor(.lightGray, for: .highlighted)
        cancelButton.titleLabel?.font = UIFont(name: "Menlo", size: 16)
        return cancelButton
    }()
    
    private lazy var saveButton: UIButton = {
        let doneButton = UIButton()
        doneButton.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
        doneButton.setTitle("save", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.setTitleColor(.darkGray, for: .highlighted)
        doneButton.titleLabel?.font = UIFont(name: "Menlo", size: 16)
        return doneButton
    }()
    
    deinit { print("no memory leadks from savedPassword")}
    
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
    }
    
    private func headerInterfaceStyle() {
        
        [appTextField, accountTextField, passwordTextField, dateLabel].forEach({ headerView.addSubview($0) })
        
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
        dateLabel.layout(top: passwordTextField.bottomAnchor, leading: passwordTextField.leadingAnchor, bottom: nil, trailing: passwordTextField.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
        
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
        if accountTextField.text?.isEmpty == true && passwordTextField.text?.isEmpty == true {
            alertMessage(title: "Delete", message: "Do you want to delete this file ?")
        }
        
        if accountTextField.text != "" && passwordTextField.text != "" {
            passwordId?.account = accountTextField.text
            passwordId?.password = passwordTextField.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss E, d MMM y"
            passwordId?.date = "Modified on \(dateFormatter.string(from: Date()))"
            do {
                NotificationCenter.default.post(name: .updatePasswordsViewController, object: nil)
                try context.save()
                dismiss(animated: true, completion: nil)
            }
            
            catch { print("could not save") }
        }
    }
    
    private func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { _ in })
        let ok = UIAlertAction(title: "Ok", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.context.delete(self.passwordId!)
            self.dismiss(animated: true, completion: nil)
            do {
                try self.context.save()
                NotificationCenter.default.post(name: .updatePasswordsViewController, object: nil)
            }
            catch {
                print(error)
            }
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func cancelClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - tableView dataSource

extension SavedPassword {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
}
