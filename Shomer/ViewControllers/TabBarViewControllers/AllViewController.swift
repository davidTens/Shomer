//
//  ViewController.swift
//  Shomer
//
//  Created by David T on 4/18/21.
//

import UIKit

final class AllViewController: UITableViewController {
    
    lazy var cellIdForHeader0 = "cellId0"
    lazy var cellIdForHeader1 = "cellId1"
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var passwords = [Passwords]()
    lazy var notes = [Notes]()
    private lazy var backgroundGradient = ViewControllerBackgruondGradient()
    private lazy var gradientLayer = ViewControllerGradientLayer(layer: CALayer())
    
    lazy var header0 = UIView()
    lazy var header1 = UIView()
    fileprivate lazy var label0 = UILabel()
    fileprivate lazy var label1 = UILabel()
    
    private let customRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 85, right: 0)
        tableView.separatorStyle = .none
        customRefreshControl.tintColor = .white
        customRefreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.addSubview(customRefreshControl)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdForHeader0)
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: cellIdForHeader1)
        interface()
        navigationBarSetUp()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = backgroundGradient.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: .updatePasswordsViewController, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: .updateNotesViewController, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func interface() {
        tableView.addSubview(backgroundGradient)
        backgroundGradient.frame = tableView.frame
        backgroundGradient.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundGradient
    }
    
    private func navigationBarSetUp() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: "#2E315A", alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.title = "All"
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(lockScreenAppear))
    }
    
    @objc private func fetchData() {
        do {
            passwords = try context.fetch(Passwords.fetchRequest())
            notes = try context.fetch(Notes.fetchRequest())
            
            DispatchQueue.main.async {
                self.customRefreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
        catch {
            print("could not fetch")
        }
    }
    
    @objc private func lockScreenAppear() {
        dismiss(animated: true, completion: nil)
    }
    
    func presentAlert(_ message: String) {
        let alert = UIAlertController(title: "Copied to clipboard", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in })
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func headerSetup(section: Int) {
        header0.backgroundColor = #colorLiteral(red: 0.2398715913, green: 0.2449896038, blue: 0.3824397922, alpha: 1)
        header1.backgroundColor = #colorLiteral(red: 0.2398715913, green: 0.2449896038, blue: 0.3824397922, alpha: 1)
        label0.textColor = .white
        label1.textColor = .white
        label0.text = "Passwords"
        label1.text = "Notes"
        label0.font = .boldSystemFont(ofSize: 16)
        label1.font = .boldSystemFont(ofSize: 16)
        
        header0.addSubview(label0)
        header1.addSubview(label1)
        label0.layout(top: header0.topAnchor, leading: header0.leadingAnchor, bottom: header0.bottomAnchor, trailing: header0.trailingAnchor, padding: .init(top: 3, left: 20, bottom: 3, right: 20))
        label1.layout(top: header1.topAnchor, leading: header1.leadingAnchor, bottom: header1.bottomAnchor, trailing: header1.trailingAnchor, padding: .init(top: 3, left: 20, bottom: 3, right: 20))
    }

}

