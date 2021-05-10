//
//  LockedViewPresenter.swift
//  Shomer
//
//  Created by David T on 5/9/21.
//

import Foundation
import UIKit
import LocalAuthentication

protocol LockedViewDelegate: NSObjectProtocol {
    func successfulBiometricAuth()
    func unSuccessfulBiometricAuth()
    func presentEnterPasswrodVC()
    func presentNewPasswordVC()
    func eraseAll()
    func addNewClicked()
}

class LockedViewPresenter: NSObject {
    
    weak var lockedViewDelegate: LockedViewDelegate?
    
    func checkUserValidity() {
        if UserDefaults.standard.bioAuthEnabled() == true {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                
                let reason = "Identify yourself"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authError in
                    guard let self = self else { return }
                    
                    DispatchQueue.main.async {
                        if success {
                            self.lockedViewDelegate?.successfulBiometricAuth()
                        } else {
                            self.lockedViewDelegate?.unSuccessfulBiometricAuth()
                        }
                    }
                }
            } else {
                self.lockedViewDelegate?.presentEnterPasswrodVC()
            }
            
        } else {
            if UserDefaults.standard.setPasswordEnabled() == true {
                self.lockedViewDelegate?.presentEnterPasswrodVC()
            } else {
                self.lockedViewDelegate?.presentNewPasswordVC()
            }
        }
    }
    
    func eraseAll() {
        if UserDefaults.standard.passwordEnabledToEraseAll() == true {
            
        } else {
            
        }
    }
    
}
