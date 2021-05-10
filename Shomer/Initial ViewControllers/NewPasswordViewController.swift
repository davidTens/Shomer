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
    private var maxLength = 5
    
    private lazy var warningMessage: UIButton = {
        let warningMessage = UIButton()
        warningMessage.addTarget(self, action: #selector(warningMessageDissapear), for: .touchUpInside)
        warningMessage.setTitle("Max number of characters \(maxLength)", for: .normal)
        warningMessage.titleLabel?.font = UIFont(name: "Avenir", size: 18)
        warningMessage.titleLabel?.textAlignment = .center
        warningMessage.setTitleColor(.white, for: .normal)
        warningMessage.backgroundColor = #colorLiteral(red: 0.5982155204, green: 0.3845223784, blue: 1, alpha: 1)
        return warningMessage
    }()
    
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
    
    private func warningMessageAppear() {
        
        if warningMessage.superview == nil {
            warningMessage.frame = CGRect(x: view.frame.width / 2, y: 0, width: 0, height: 0)
            view.addSubview(warningMessage)
            warningMessage.layout(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 50))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc private func warningMessageDissapear() {
        warningMessage.translatesAutoresizingMaskIntoConstraints = true
        warningMessage.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        warningMessage.removeFromSuperview()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneClicked()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if passwordTextField == textField {
            let currentText = textField.text! + string
            warningMessageAppear()
            return currentText.count <= maxLength
        }
        if retypeTextField == textField  {
            let currentText = textField.text! + string
            return currentText.count <= maxLength
        }
         return true
       }
    
    @objc private func showTabBar() {
        let tabbar = TabBarController()
        tabbar.modalPresentationStyle = .fullScreen
        present(tabbar, animated: true, completion: nil)
    }
    
    private func enabledBiometrics() {
        UserDefaults.standard.setBioAuthEnabled(true)
        showTabBar()
    }
    
    private func doneClicked() {
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
                let alert = UIAlertController(title: "Biometry Auth", message: "Would you like to enable biomentric authentication ?", preferredStyle: .alert)
                let noThanks = UIAlertAction(title: "No Thanks", style: .cancel) { [weak self] _ in
                    self?.showTabBar()
                }
                let alertAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
                    self?.enabledBiometrics()
                }
                alert.addAction(noThanks)
                alert.addAction(alertAction)
                present(alert, animated: true) { [weak self] in
                    self?.perform(#selector(self?.showTabBar), with: nil, afterDelay: 0.01)
                }
            } else if retypeTextField.text?.isEmpty == false, retypeTextField.text != passwordTextField.text {
                retypeLine.backgroundColor = .red
            }
        }
    }
    
    private func retypeAppear() {
        
        retypeTextField.alpha = 1
        retypeLine.alpha = 1
        retypeTextField.becomeFirstResponder()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
            self.view.layoutIfNeeded()
        }, completion: nil)

    }
}
