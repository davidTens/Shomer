//
//  LockedViewExtensions.swift
//  Shomer
//
//  Created by David T on 5/11/21.
//

import UIKit

extension LockedViewController: LockedViewDelegate {
        
    func successfulBiometricAuth() {
        let tabbar = TabBarController()
        tabbar.modalPresentationStyle = .fullScreen
        present(tabbar, animated: true, completion: nil)
    }
    
    func unSuccessfulBiometricAuth() {
        let enter = EnterPasswordViewController()
        enter.modalPresentationStyle = .popover
        present(enter, animated: true, completion: nil)
    }
    
    func presentEnterPasswrodVC() {
        let enter = EnterPasswordViewController()
        enter.modalPresentationStyle = .popover
        present(enter, animated: true, completion: nil)
    }
    
    func presentNewPasswordVC() {
        let tabBarVC = NewPasswordViewController()
        tabBarVC.modalPresentationStyle = .popover
        present(tabBarVC, animated: true, completion: nil)
    }
    
    func passwordToDeleteAll() {
        let toEraseAll = EnterPasswordToDeleteAll()
        toEraseAll.modalPresentationStyle = .popover
        present(toEraseAll, animated: true, completion: nil)
    }
    
    func presentAlertToEraseAll() {
        let alert = UIAlertController(title: "Erase All", message: "Are you sure you want to erase all?", preferredStyle: .alert)
        let alertAction0 = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        let alertAction1 = UIAlertAction(title: "Erase All", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.presenter.deleteAll()
        }
        alert.addAction(alertAction0)
        alert.addAction(alertAction1)
        present(alert, animated: true, completion: nil)
    }
}
