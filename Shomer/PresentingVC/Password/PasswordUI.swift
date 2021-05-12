//
//  PasswordUI.swift
//  Shomer
//
//  Created by David T on 5/12/21.
//

import UIKit

final class PasswordAppTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attributedPlaceholder = NSAttributedString(string: "app", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#9B9898", alpha: 0.8)])
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        font = UIFont(name: "Avenir", size: 16)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftViewMode = .always
        clearButtonMode = .whileEditing
        keyboardAppearance = .dark
        clearButtonMode = .always
        textColor = .white
        layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class PasswordAccountTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attributedPlaceholder = NSAttributedString(string: "Account", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#9B9898", alpha: 0.8)])
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        font = UIFont(name: "Avenir", size: 16)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftViewMode = .always
        clearButtonMode = .whileEditing
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

final class PasswordPasswordTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#9B9898", alpha: 0.8)])
        isSecureTextEntry = false
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        font = UIFont(name: "Avenir", size: 16)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        leftViewMode = .always
        keyboardAppearance = .dark
        textColor = .white
        layer.cornerRadius = 6
        clearsOnBeginEditing = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class DateLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont(name: "Avenir", size: 18)
        adjustsFontSizeToFitWidth = true
        backgroundColor = .clear
        textAlignment = .left
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
