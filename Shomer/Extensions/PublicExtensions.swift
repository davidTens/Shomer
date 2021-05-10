//
//  PublicExtensions.swift
//  Shomer
//
//  Created by David T on 4/18/21.
//

import UIKit
import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case bioAuth
        case passwordEnabledToEraseAll
        case passwordIsEnabled
        case passwordString
        case visiblePasswords
    }
    
    func bioAuthEnabled() -> Bool {
        return bool(forKey: UserDefaultsKeys.bioAuth.rawValue)
    }
    
    func setBioAuthEnabled(_ bool: Bool) {
        setValue(bool, forKey: UserDefaultsKeys.bioAuth.rawValue)
        synchronize()
    }
    
    func passwordEnabledToEraseAll() -> Bool {
        return bool(forKey: UserDefaultsKeys.passwordEnabledToEraseAll.rawValue)
    }
    
    func setpasswordEnabledToEraseAll(_ bool: Bool) {
        setValue(bool, forKey: UserDefaultsKeys.passwordEnabledToEraseAll.rawValue)
        synchronize()
    }
    
    func setPasswordEnabled() -> Bool {
        return bool(forKey: UserDefaultsKeys.passwordIsEnabled.rawValue)
    }
    
    func passwordIsEnabled(_ bool: Bool) {
        setValue(bool, forKey: UserDefaultsKeys.passwordIsEnabled.rawValue)
        synchronize()
    }
    
    func passwordString() -> String {
        return string(forKey: UserDefaultsKeys.passwordString.rawValue)!
    }
    
    func setPasswordString(_ password: String) {
        setValue(password, forKey: UserDefaultsKeys.passwordString.rawValue)
        synchronize()
    }
    
    func visiblePasswords() -> Bool {
        return bool(forKey: UserDefaultsKeys.visiblePasswords.rawValue)
    }
    
    func setVisiblePasswords(_ bool: Bool) {
        setValue(bool, forKey: UserDefaultsKeys.visiblePasswords.rawValue)
        synchronize()
    }
}


extension UIView {
    
    func fillSuperview() {
        layout(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func xyAnchors(x: NSLayoutXAxisAnchor?, y: NSLayoutYAxisAnchor?, size: CGSize = .zero, xPadding: CGFloat = .zero, yPadding: CGFloat = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let x = x {
            centerXAnchor.constraint(equalTo: x, constant: xPadding).isActive = true
        }
        
        if let y = y {
            centerYAnchor.constraint(equalTo: y, constant: yPadding).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
    
    func layout(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
            
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
            
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
            
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
            
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
    
}


extension UIColor {
    
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}


extension Notification.Name {
    
    static let updatePasswordsViewController = Notification.Name("updatePasswordsViewController")
    static let updateNotesViewController = Notification.Name("updateNotesViewController")
}
