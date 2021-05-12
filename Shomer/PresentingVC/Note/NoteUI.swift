//
//  NoteUI.swift
//  Shomer
//
//  Created by David T on 5/12/21.
//

import UIKit

final class NoteTitleTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont(name: "Avenir", size: 16)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftViewMode = .always
        rightViewMode = .always
        textAlignment = .left
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        textColor = .white
        layer.cornerRadius = 10
        clearButtonMode = .whileEditing
        keyboardAppearance = .dark
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class NoteTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        font = .systemFont(ofSize: 15)
        textAlignment = .left
        isEditable = true
        isScrollEnabled = true
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        layer.cornerRadius = 10
        textColor = .white
        keyboardAppearance = .dark
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
