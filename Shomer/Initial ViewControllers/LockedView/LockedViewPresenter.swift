//
//  LockedViewPresenter.swift
//  Shomer
//
//  Created by David T on 5/9/21.
//

import Foundation
import UIKit
import LocalAuthentication
import CoreData

protocol LockedViewDelegate: NSObjectProtocol {
    func successfulBiometricAuth()
    func unSuccessfulBiometricAuth()
    func presentEnterPasswrodVC()
    func presentNewPasswordVC()
    func presentAlertToEraseAll()
    func passwordToDeleteAll()
}

final class LockedViewPresenter: NSObject {
    
    weak var lockedViewDelegate: LockedViewDelegate?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    func deleteAll() {
        let deletePasswords = NSBatchDeleteRequest(fetchRequest: Passwords.fetchRequest())
        let deleteNotes = NSBatchDeleteRequest(fetchRequest: Notes.fetchRequest())
        do {
            try context.execute(deletePasswords)
            try context.execute(deleteNotes)
            
        }
        catch { print(error) }
        
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.bioAuth.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.passwordEnabledToEraseAll.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.passwordIsEnabled.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.passwordString.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.visiblePasswords.rawValue)
    }
}
