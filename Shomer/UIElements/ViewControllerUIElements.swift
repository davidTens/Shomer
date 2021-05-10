//
//  ViewControllerUIElements.swift
//  Shomer
//
//  Created by David T on 5/9/21.
//

import UIKit

final class ViewControllerBackgruondGradient: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class ViewControllerGradientLayer: CAGradientLayer {
    
    override init(layer: Any) {
        super.init(layer: layer)
        startPoint = CGPoint(x: 0.5, y: 0)
        endPoint = CGPoint(x: 1, y: 1)
        colors = [UIColor(hexFromString: "#262D40").cgColor, UIColor(hexFromString: "#6470A3").cgColor]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class ViewControllerErrorMessage: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.5401135087, green: 0.3391100168, blue: 0.9402614236, alpha: 0.9006822599)
        setTitle("Error occured", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Avenir", size: 18)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class ButtonsBackground: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexFromString: "#3B3B3B", alpha: 0.6)
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = 13
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class VerticalLine: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexFromString: "#707070")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CancelButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("cancel", for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
        titleLabel?.font = UIFont(name: "Menlo", size: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SaveButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("save", for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
        titleLabel?.font = UIFont(name: "Menlo", size: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - AddNewNotesUIElements


