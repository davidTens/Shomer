//
//  ViewController.swift
//  Shomer
//
//  Created by David T on 4/18/21.
//

import UIKit

final class AllViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    private let searchController = UISearchController(searchResultsController: nil)
    fileprivate lazy var cellIdForHeader0 = "cellId0"
    fileprivate lazy var cellIdForHeader1 = "cellId1"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    fileprivate var passwords = [Passwords]()
    fileprivate var notes = [Notes]()
    private lazy var backgroundGradient = ViewControllerBackgruondGradient()
    private lazy var gradientLayer = ViewControllerGradientLayer(layer: CALayer())
    
    fileprivate lazy var header0 = UIView()
    fileprivate lazy var header1 = UIView()
    fileprivate lazy var label0 = UILabel()
    fileprivate lazy var label1 = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdForHeader0)
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: cellIdForHeader1)
        interface()
        navigationBarSetUp()
        let message = UILabel()
        message.text = "Not ready yet"
        message.font = .boldSystemFont(ofSize: 20)
        message.textColor = .white
        message.textAlignment = .center
        backgroundGradient.addSubview(message)
        message.fillSuperview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = backgroundGradient.bounds
    }
    
    private func interface() {
        tableView.addSubview(backgroundGradient)
        backgroundGradient.frame = tableView.frame
        backgroundGradient.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundGradient
    }
    
    private func navigationBarSetUp() {
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: "#2E315A", alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.title = "All"
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(lockScreenAppear))
        navigationItem.searchController = searchController
        
        searchController.delegate = self
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        let searchBarTextField = searchController.searchBar.value(forKey: "searchField") as! UITextField
        let searchIconView = searchBarTextField.leftView as? UIImageView
        searchIconView?.image = searchIconView?.image?.withRenderingMode(.alwaysTemplate)
        searchIconView?.tintColor = .lightGray
        searchBarTextField.textColor = .white
    }
    
    private func headerSetup(section: Int) {
        header0.backgroundColor = .red
        header0.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header0)
        header0.addSubview(label0)
        label0.textColor = .white
        label0.text = section == 0 ? "Passwords" : "Notes"
        
        header0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        header0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        header0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        header0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label0.layout(top: header0.topAnchor, leading: header0.leadingAnchor, bottom: header0.bottomAnchor, trailing: header0.trailingAnchor, padding: .init(top: 4, left: 20, bottom: 4, right: 8))
    }
    
    private func fetchData() {
        do {
            passwords = try context.fetch(Passwords.fetchRequest())
            notes = try context.fetch(Notes.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print("could not fetch")
        }
    }
    
    @objc private func lockScreenAppear() {
        let lockScreen = LockedViewController()
        lockScreen.modalPresentationStyle = .fullScreen
        present(lockScreen, animated: true, completion: nil)
    }
    
    @objc private func settingsButtonPressed() {
        print("settings button pressed")
    }
    
    // MARK: - tableView dataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForHeader0) as! CustomTableViewCell
            cell.titleLabel.text = passwords[indexPath.row].account
            cell.subTitle.text = passwords[indexPath.row].password
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForHeader1) as! NotesTableViewCell
            cell.titleLabel.text = notes[indexPath.row].title
            cell.subTitle.text = notes[indexPath.row].text
            return cell
        }
        
    }

}

