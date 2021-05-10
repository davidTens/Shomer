//
//  AddNewPassword.swift
//  Shomer
//
//  Created by David T on 5/9/21.
//

import UIKit

final class AppTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attributedPlaceholder = NSAttributedString(string: "app", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#9B9898", alpha: 0.8)])
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        font = UIFont(name: "Avenir", size: 18)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftViewMode = .always
        rightViewMode = .always
        keyboardAppearance = .dark
        clearButtonMode = .always
        textColor = .white
        layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AccountTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attributedPlaceholder = NSAttributedString(string: "account", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#9B9898", alpha: 0.8)])
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        font = UIFont(name: "Avenir", size: 18)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftViewMode = .always
        rightViewMode = .always
        keyboardAppearance = .dark
        clearButtonMode = .always
        textColor = .white
        layer.cornerRadius = 6
        keyboardType = .emailAddress
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class PasswordTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#9B9898", alpha: 0.8)])
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        font = UIFont(name: "Avenir", size: 18)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftViewMode = .always
        rightViewMode = .always
        keyboardAppearance = .dark
        clearButtonMode = .always
        textColor = .white
        layer.cornerRadius = 6
        isSecureTextEntry = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AppBottomLine: UIView  {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AccountBottomLine: UIView  {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class PasswordBottomLine: UIView  {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
