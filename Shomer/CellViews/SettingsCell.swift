//
//  AddNewCellView.swift
//  Shomer
//
//  Created by David T on 4/30/21.
//

import UIKit

final class SettingsCell: UITableViewCell {
    
    lazy var titleTextLabel: UILabel = {
       let titleTextLabel = UILabel()
        titleTextLabel.textColor = .white
        titleTextLabel.font = UIFont(name: "Avenir", size: 16)
        return titleTextLabel
    }()
    
    var switchValueHandler: ((_ sender: UISwitch) -> Void)?
    
    lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.isUserInteractionEnabled = true
        switcher.onTintColor = #colorLiteral(red: 0.5260028243, green: 0.1564305723, blue: 1, alpha: 1)
        switcher.isOn = false
        return switcher
    }()
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        switchValueHandler?(sender)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(hexFromString: "#333764", alpha: 0.8)
//            UIColor(hexFromString: "#3A3F76")
        addSubview(switcher)
        addSubview(titleTextLabel)
        
        switcher.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switcher.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        titleTextLabel.layout(top: topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 5, left: 15, bottom: 5, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
