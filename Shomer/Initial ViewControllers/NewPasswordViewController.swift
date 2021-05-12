//
//  PasswordViewController.swift
//  Shomer
//
//  Created by David T on 5/4/21.
//

import UIKit

final class NewPasswordViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "New Password"
        return label
    }()
    
    private lazy var passwordTextField = UITextField()
    private lazy var retypeTextField = UITextField()
    private lazy var passwordLine = UIView()
    private lazy var retypeLine = UIView()
    private lazy var lockedView = LockedViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4333997667, green: 0.2445830107, blue: 0.835003376, alpha: 1)
        
        view.addSubview(label)
        
        retypeTextField.alpha = 0
        retypeLine.alpha = 0
        
        [passwordTextField, retypeTextField].forEach({ textfield in
            textfield.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            textfield.isSecureTextEntry = true
            textfield.textColor = .white
            textfield.font = .systemFont(ofSize: 18)
            textfield.textAlignment = .center
            textfield.placeholder = "..."
            textfield.returnKeyType = .done
            textfield.layer.cornerRadius = 10
            textfield.delegate = self
            textfield.clearButtonMode = .always
            view.addSubview(textfield)
        })
        
        retypeTextField.placeholder = "re-enter"
        
        [passwordLine, retypeLine].forEach({ line in
            line.backgroundColor = .white
            line.layer.cornerRadius = 3
            view.addSubview(line)
        })
        
        label.layout(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
        passwordTextField.layout(top: label.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 15, left: 70, bottom: 0, right: 70), size: .init(width: 0, height: 50))
        passwordLine.layout(top: passwordTextField.bottomAnchor, leading: passwordTextField.leadingAnchor, bottom: nil, trailing: passwordTextField.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15), size: .init(width: 0, height: 1))
        
        retypeTextField.layout(top: passwordLine.bottomAnchor, leading: passwordTextField.leadingAnchor, bottom: nil, trailing: passwordTextField.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
        retypeLine.layout(top: retypeTextField.bottomAnchor, leading: retypeTextField.leadingAnchor, bottom: nil, trailing: retypeTextField.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15), size: .init(width: 0, height: 1))
        passwordTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createUser()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == retypeTextField {
            if passwordTextField.text == retypeTextField.text {
                createUser()
            }
        }
    }
    
    @objc private func successfulAuth() {
        let tabbar = TabBarController()
        tabbar.modalPresentationStyle = .fullScreen
        present(tabbar, animated: true, completion: nil)
    }
    
    private func enabledBiometrics() {
        UserDefaults.standard.setBioAuthEnabled(true)
        successfulAuth()
    }
    
    private func createUser() {
        if passwordTextField.text?.isEmpty == true {
            passwordLine.backgroundColor = .red
        } else if passwordTextField.text != "" {
            passwordLine.backgroundColor = .white
            passwordTextField.resignFirstResponder()
            retypeAppear()
            
            if retypeTextField.text == passwordTextField.text {
                retypeLine.backgroundColor = .white
                UserDefaults.standard.setPasswordString(retypeTextField.text!)
                UserDefaults.standard.passwordIsEnabled(true)
                let alert = UIAlertController(title: "Biometric Auth", message: "Would you like to enable biomentric authentication ?", preferredStyle: .alert)
                let noThanks = UIAlertAction(title: "No Thanks", style: .cancel) { [weak self] _ in
                    self?.successfulAuth()
                }
                let alertAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
                    self?.enabledBiometrics()
                }
                alert.addAction(noThanks)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
            } else if retypeTextField.text?.isEmpty == false, retypeTextField.text != passwordTextField.text {
                retypeLine.backgroundColor = .red
            }
        }
    }
    
    private func retypeAppear() {
        retypeTextField.alpha = 1
        retypeLine.alpha = 1
        retypeTextField.becomeFirstResponder()
    }
}
