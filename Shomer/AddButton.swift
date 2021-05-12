//
//  AddButton.swift
//  Shomer
//
//  Created by David T on 4/19/21.
//

import UIKit

final class AddButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
