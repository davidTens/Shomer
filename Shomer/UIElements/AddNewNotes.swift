//
//  AddNewNotes.swift
//  Shomer
//
//  Created by David T on 5/9/21.
//

import UIKit

final class AddNewNotesBackgroundGradient: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3.5)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AddNewNotesGradientLayer: CAGradientLayer {
    
    override init(layer: Any) {
        super.init(layer: layer)
        startPoint = CGPoint(x: 0.5, y: 0)
        endPoint = CGPoint(x: 1, y: 1)
        colors = [UIColor(hexFromString: "#262D40").cgColor, UIColor(hexFromString: "#34406C").cgColor]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AddNewNotesTitleTextField: UITextField {
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AddNewNotesTextFieldBottomLIne: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AddNewNotesTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        font = UIFont(name: "Aevnir", size: 16)
        textAlignment = .left
        isEditable = true
        isScrollEnabled = false
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        layer.cornerRadius = 10
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AddNewNotesTexViewBottomLine: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
