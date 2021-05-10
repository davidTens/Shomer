//
//  EnterPasswordViewController.swift
//  Shomer
//
//  Created by David T on 5/5/21.
//

import UIKit

final class EnterPasswordViewController: UIViewController, UITextFieldDelegate {
    
    private let maxLength = 5
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Enter Password"
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        textfield.isSecureTextEntry = true
        textfield.textColor = .white
        textfield.font = .systemFont(ofSize: 18)
        textfield.textAlignment = .center
        textfield.placeholder = "password"
        textfield.returnKeyType = .done
        textfield.layer.cornerRadius = 10
        textfield.delegate = self
        textfield.clearButtonMode = .always
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5819670558, green: 0.3667315543, blue: 1, alpha: 1)
        interface()
        passwordTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordTextField.becomeFirstResponder()
    }
    
    private func interface() {
        view.addSubview(label)
        view.addSubview(passwordTextField)
        label.layout(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
        passwordTextField.layout(top: label.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 15, left: 70, bottom: 0, right: 70), size: .init(width: 0, height: 50))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if UserDefaults.standard.passwordString() == passwordTextField.text {
            showTabBar()
        } else {
            label.textColor = .red
            label.text = "Wrong password"
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if passwordTextField == textField {
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
}
