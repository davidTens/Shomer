//
//  PasswordsViewController.swift
//  Shomer
//
//  Created by David T on 4/20/21.
//

import UIKit

final class PasswordsViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    let cellId = "cellId"
    lazy var passwords = [Passwords]()
    lazy var filteredPasswords = [Passwords]()
    let searchController = UISearchController(searchResultsController: nil)
    private var customRefreshControll = UIRefreshControl()
    private lazy var errorMessageTopAnchor = NSLayoutConstraint()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let darkModeGradientColors = [UIColor(hexFromString: "#262D40").cgColor, UIColor(hexFromString: "#6470A3").cgColor]
    
    private lazy var backgroundGradient = ViewControllerBackgruondGradient()
    private lazy var gradientLayer = ViewControllerGradientLayer(layer: CALayer())
    private lazy var errorMessage = ViewControllerErrorMessage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customRefreshControll.tintColor = .white
        customRefreshControll.addTarget(self, action: #selector(fetchPasswords), for: .valueChanged)
        errorMessage.addTarget(self, action: #selector(dissapearErrorMessage), for: .touchUpInside)
        tableView.addSubview(customRefreshControll)
        tableView.separatorStyle = .none
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
        navigationBarSetUp()
        interface()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = backgroundGradient.bounds
    }
    
    @objc func fetchPasswords() {
        do {
            passwords = try context.fetch(Passwords.fetchRequest())
            
            DispatchQueue.main.async { [weak self] in
                self?.customRefreshControll.endRefreshing()
                self?.tableView.reloadData()
            }
        }
        catch {
            print("could not fetch")
        }
    }
    
    private func navigationBarSetUp() {
        
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: "#2E315A", alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.title = "Passwords"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.tintColor = .white
        navigationItem.searchController = searchController
        
        searchController.delegate = self
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        let searchBarTextField = searchController.searchBar.value(forKey: "searchField") as! UITextField
        let searchIconView = searchBarTextField.leftView as? UIImageView
        searchIconView?.image = searchIconView?.image?.withRenderingMode(.alwaysTemplate)
        searchIconView?.tintColor = .lightGray
        searchBarTextField.textColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchPasswords), name: .updatePasswordsViewController, object: nil)
        fetchPasswords()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func presentAlert(_ message: String) {
        let alert = UIAlertController(title: "Copied to clipboard", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in })
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func interface() {
        tableView.addSubview(backgroundGradient)
        backgroundGradient.frame = tableView.frame
        backgroundGradient.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundGradient
    }
    
    @objc private func appearErrorMessage() {
        customRefreshControll.endRefreshing()
        view.insertSubview(errorMessage, aboveSubview: view)
        errorMessage.layout(top: view.safeAreaLayoutGuide.topAnchor, leading: backgroundGradient.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: backgroundGradient.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 50))
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func dissapearErrorMessage() {
        errorMessage.removeFromSuperview()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterPasswords(searchBarText: searchController.searchBar.text!)
    }
    
    private func filterPasswords(searchBarText: String, scope: String = "All") {
        filteredPasswords = passwords.filter({ password in
            return password.account!.lowercased().contains(searchBarText.lowercased())
        })
        tableView.reloadData()
    }
    
    func popUpPasswordId(_ id: Passwords) {
        let savedPassword = SavedPassword()
        savedPassword.passwordId = id
        savedPassword.modalPresentationStyle = .popover
        present(savedPassword, animated: true, completion: nil)
    }
}
