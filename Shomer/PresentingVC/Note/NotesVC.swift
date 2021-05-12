//
//  SavedNote.swift
//  Shomer
//
//  Created by David T on 5/7/21.
//

import UIKit

final class NotesVC: UITableViewController {
    
    let cellId = "cellId"
    lazy var headerView = UIView()
    let headerHeight: CGFloat = 420
    private let textViewPadding: CGFloat = 15
    private let gradientColors = [UIColor(hexFromString: "#262D40").cgColor, UIColor(hexFromString: "#34406C").cgColor]
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var noteId: Notes? {
        didSet {
            titleTextField.text = noteId?.title
            textView.text = noteId?.text
            dateLabel.text = noteId?.date
        }
    }
    
    private lazy var backgroundGradient: UIView = {
        let backgroundGradient = UIView()
        backgroundGradient.backgroundColor = .clear
        backgroundGradient.layer.masksToBounds = false
        backgroundGradient.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        backgroundGradient.layer.shadowOffset = CGSize(width: 0, height: 3.5)
        backgroundGradient.layer.shadowRadius = 5.0
        backgroundGradient.layer.shadowOpacity = 1.0
        return backgroundGradient
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = gradientColors
        return gradientLayer
    }()
    
    private lazy var titleTextField = NoteTitleTextField()
    private lazy var textView = NoteTextView()
    
    private lazy var textFieldBottomLine: UIView = {
        let textFieldBottomLine = UIView()
        textFieldBottomLine.backgroundColor = .white
        textFieldBottomLine.layer.cornerRadius = 3
        return textFieldBottomLine
    }()
    
    private lazy var textViewBottomLine: UIView = {
        let textViewBottomLine = UIView()
        textViewBottomLine.backgroundColor = .white
        textViewBottomLine.layer.cornerRadius = 3
        return textViewBottomLine
    }()
    
    private lazy var buttonsBackground: UIView = {
        let buttonsBackground = UIView()
        buttonsBackground.backgroundColor = UIColor(hexFromString: "#3B3B3B", alpha: 0.6)
        buttonsBackground.clipsToBounds = true
        buttonsBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonsBackground.layer.cornerRadius = 13
        return buttonsBackground
    }()
    
    private lazy var verticalLine: UIView = {
        let verticalLine = UIView()
        verticalLine.backgroundColor = UIColor(hexFromString: "#707070")
        return verticalLine
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.addTarget(self, action: #selector(cancelClicked), for: .touchUpInside)
        cancelButton.setTitle("cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.setTitleColor(.lightGray, for: .highlighted)
        cancelButton.titleLabel?.font = UIFont(name: "Menlo", size: 16)
        return cancelButton
    }()
    
    private lazy var saveButton: UIButton = {
        let doneButton = UIButton()
        doneButton.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
        doneButton.setTitle("save", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.setTitleColor(.darkGray, for: .highlighted)
        doneButton.titleLabel?.font = UIFont(name: "Menlo", size: 16)
        return doneButton
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "Avenir", size: 18)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.backgroundColor = .clear
        dateLabel.textAlignment = .center
        dateLabel.textColor = .white
        return dateLabel
    }()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tableView.endEditing(true)
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
        
        headerView.addSubview(dateLabel)
        headerView.addSubview(titleTextField)
        headerView.addSubview(textFieldBottomLine)
        headerView.addSubview(textView)
        headerView.addSubview(textViewBottomLine)
        
        dateLabel.layout(top: nil, leading: headerView.leadingAnchor, bottom: buttonsBackground.topAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: textViewPadding, bottom: textViewPadding, right: textViewPadding), size: .init(width: 0, height: 24))
        titleTextField.layout(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15), size: .init(width: 0, height: 40))
        textFieldBottomLine.layout(top: titleTextField.bottomAnchor, leading: titleTextField.leadingAnchor, bottom: nil, trailing: titleTextField.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15), size: .init(width: 0, height: 1))
        textView.layout(top: titleTextField.bottomAnchor, leading: headerView.leadingAnchor, bottom: dateLabel.topAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 15, left: textViewPadding, bottom: textViewPadding, right: textViewPadding))
        textViewBottomLine.layout(top: textView.bottomAnchor, leading: textView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15), size: .init(width: 0, height: 1))
        
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
        if titleTextField.text?.isEmpty == true && textView.text.isEmpty == true {
            alertMessage(title: "Delete", message: "Do you want to delete this file ?")
        }
        if titleTextField.text != "" && textView.text != "" {
            noteId?.title = titleTextField.text
            noteId?.text = textView.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss E, d MMM y"
            noteId?.date = "Created on \(dateFormatter.string(from: Date()))"
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
    
    private func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { _ in })
        let ok = UIAlertAction(title: "Ok", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.context.delete(self.noteId!)
            self.dismiss(animated: true, completion: nil)
            do {
                try self.context.save()
                NotificationCenter.default.post(name: .updateNotesViewController, object: nil)
            }
            catch {
                print(error)
            }
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

