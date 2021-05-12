//
//  QuickAccessCellView.swift
//  Shomer
//
//  Created by David T on 4/20/21.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    var password: Passwords? {
        didSet {
            titleLabel.text = password?.account
            subTitle.text = password?.password
        }
    }
    
    var presentAlert: ((_ message: String) -> Void)?
    
    private let lockImageViewISize: CGFloat = 30
    
    private lazy var customBackgroundView: UIView = {
        let customBackgroundView = UIView()
        customBackgroundView.backgroundColor = UIColor(hexFromString: "#313C63", alpha: 0.8)
        customBackgroundView.layer.cornerRadius = 13
        return customBackgroundView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Avenir", size: 16)
        return titleLabel
    }()
    
    lazy var subTitle: UITextField = {
        let subTitle = UITextField()
        subTitle.font = .systemFont(ofSize: 15)
        subTitle.textAlignment = .left
        subTitle.backgroundColor = .clear
        subTitle.textColor = .lightGray
        return subTitle
    }()
    
    lazy var copyImageView: UIImageView = {
        let copyImageView = UIImageView()
        copyImageView.isUserInteractionEnabled = true
        copyImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyPasswordToClipboard)))
        copyImageView.translatesAutoresizingMaskIntoConstraints = false
        copyImageView.isUserInteractionEnabled = true
        copyImageView.image = UIImage(named: "cccc")?.withRenderingMode(.alwaysTemplate)
        copyImageView.tintColor = .white
        return copyImageView
    }()
    
    private func uiSetup() {
        addSubview(customBackgroundView)
        addSubview(copyImageView)
        addSubview(titleLabel)
        addSubview(subTitle)
        
        customBackgroundView.layout(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 14, bottom: 6, right: 14))
        
        [
            copyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            copyImageView.heightAnchor.constraint(equalToConstant: lockImageViewISize),
            copyImageView.widthAnchor.constraint(equalToConstant: lockImageViewISize),
            copyImageView.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -12)
            
        ].forEach({ $0.isActive = true })
        
        titleLabel.layout(top: nil, leading: customBackgroundView.leadingAnchor, bottom: centerYAnchor, trailing: copyImageView.leadingAnchor, padding: .init(top: 0, left: 12, bottom: 1, right: 8))
        subTitle.layout(top: centerYAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 9, right: 0))
    }
    
    @objc private func copyPasswordToClipboard() {
        let pasteboard = UIPasteboard.general
        if let pass = password?.password {
            pasteboard.string = pass
            presentAlert?(pass)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        uiSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
