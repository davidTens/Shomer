//
//  NotesTableViewCell.swift
//  Shomer
//
//  Created by David T on 5/6/21.
//

import UIKit

final class NotesTableViewCell: UITableViewCell {
    
    var note: Notes? {
        didSet {
            titleLabel.text = note?.title
            subTitle.text = note?.text
        }
    }
    
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
        subTitle.isSecureTextEntry = false
        subTitle.backgroundColor = .clear
        subTitle.textColor = .lightGray
        return subTitle
    }()
    
    private func uiSetup() {
        addSubview(customBackgroundView)
        addSubview(titleLabel)
        addSubview(subTitle)
        
        customBackgroundView.layout(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 14, bottom: 6, right: 14))
        titleLabel.layout(top: nil, leading: customBackgroundView.leadingAnchor, bottom: centerYAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 1, right: 12))
        subTitle.layout(top: centerYAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 9, right: 0))
    }
    
    @objc private func copyPasswordToClipboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = note?.text
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
