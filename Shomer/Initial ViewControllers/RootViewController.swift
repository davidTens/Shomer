//
//  RootViewController.swift
//  Shomer
//
//  Created by David T on 5/4/21.
//

import UIKit

final class RootViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lockScreen = LockedViewController()
        viewControllers = [lockScreen]
    }
}
