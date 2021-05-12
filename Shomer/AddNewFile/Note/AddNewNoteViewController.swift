//
//  AddNewNoteViewController.swift
//  Shomer
//
//  Created by David T on 5/6/21.
//

import UIKit

final class AddNewNoteViewController: UITableViewController {
    
    let cellId = "cellId"
    lazy var headerView = UIView()
    let headerHeight: CGFloat = 420
    private let textViewPadding: CGFloat = 15
    private let gradientColors = [UIColor(hexFromString: "#262D40").cgColor, UIColor(hexFromString: "#34406C").cgColor]
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - UIElements
    private lazy var backgroundGradient = AddNewNotesBackgroundGradient()
    private lazy var gradientLayer = AddNewNotesGradientLayer(layer: CALayer())
    private lazy var titleTextField = AddNewNotesTitleTextField()
    private lazy var textFieldBottomLine = AddNewNotesTextFieldBottomLIne()
    private lazy var textView = AddNewNotesTextView()
    private lazy var textViewBottomLine = AddNewNotesTextViewBottomLine()
    private lazy var buttonsBackground = ButtonsBackground()
    private lazy var verticalLine = VerticalLine()
    private lazy var cancelButton = CancelButton()
    private lazy var saveButton = SaveButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(hexFromString: "#273250")
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        titleTextField.becomeFirstResponder()
        interface()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = backgroundGradient.bounds
    }
    
    private func interface() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        [
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerHeight)
        ].forEach({ $0.isActive = true })
        
        headerView.addSubview(backgroundGradient)
        backgroundGradient.fillSuperview()
        backgroundGradient.layer.insertSublayer(gradientLayer, at: 0)
        
        headerView.addSubview(buttonsBackground)
        buttonsBackground.layout(top: nil, leading: headerView.safeAreaLayoutGuide.leadingAnchor, bottom: backgroundGradient.bottomAnchor, trailing: headerView.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 85, bottom: 0, right: 85), size: .init(width: 0, height: 50))
        
        headerView.addSubview(verticalLine)
        verticalLine.xyAnchors(x: buttonsBackground.centerXAnchor, y: buttonsBackground.centerYAnchor, size: .init(width: 1, height: 30))

        let stackView = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        buttonsBackground.addSubview(stackView)
        stackView.fillSuperview()

        headerView.addSubview(titleTextField)
        headerView.addSubview(textFieldBottomLine)
        headerView.addSubview(textView)
        headerView.addSubview(textViewBottomLine)
        titleTextField.layout(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15), size: .init(width: 0, height: 40))
        textFieldBottomLine.layout(top: titleTextField.bottomAnchor, leading: titleTextField.leadingAnchor, bottom: nil, trailing: titleTextField.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15), size: .init(width: 0, height: 1))
        textView.layout(top: titleTextField.bottomAnchor, leading: headerView.leadingAnchor, bottom: buttonsBackground.topAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 15, left: textViewPadding, bottom: textViewPadding, right: textViewPadding))
        textViewBottomLine.layout(top: textView.bottomAnchor, leading: textView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15), size: .init(width: 0, height: 1))
        
        cancelButton.addTarget(self, action: #selector(cancelClicked), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
    }
    
    @objc private func cancelClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveClicked() {
        if titleTextField.text?.isEmpty == true {
            textFieldBottomLine.backgroundColor = .red
        } else {
            textFieldBottomLine.backgroundColor = .white
        }
        if textView.text.isEmpty == true {
            textViewBottomLine.backgroundColor = .red
        } else {
            textViewBottomLine.backgroundColor = .white
        }
        if titleTextField.text != "" && textView.text != "" {
            let note = Notes(context: context)
            note.title = titleTextField.text
            note.text = textView.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss E, d MMM y"
            note.date = "Created on \(dateFormatter.string(from: Date()))"
            do {
                try context.save()
                NotificationCenter.default.post(name: .updateNotesViewController, object: nil)
                dismiss(animated: true, completion: nil)
            }
            catch {
                print("error uccured")
            }
        }
    }
}
