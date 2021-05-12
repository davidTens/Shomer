//
//  NotesViewController.swift
//  Shomer
//
//  Created by David T on 4/20/21.
//

import UIKit

final class NotesViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    let cellId = "cellId"
    let searchController = UISearchController(searchResultsController: nil)
    lazy var notes = [Notes]()
    lazy var filteredNotes = [Notes]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var customRefreshControll = UIRefreshControl()
    
    private lazy var backgroundGradient = ViewControllerBackgruondGradient()
    private lazy var gradientLayer = ViewControllerGradientLayer(layer: CALayer())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 85, right: 0)
        customRefreshControll.tintColor = .white
        customRefreshControll.addTarget(self, action: #selector(fetchNotes), for: .valueChanged)
        tableView.addSubview(customRefreshControll)
        tableView.separatorStyle = .none
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: cellId)
        navigationBarSetUp()
        interface()
        fetchNotes()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = backgroundGradient.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchNotes), name: .updateNotesViewController, object: nil)
        fetchNotes()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func fetchNotes() {
        do {
            notes = try context.fetch(Notes.fetchRequest())
            
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
        
        navigationItem.title = "Notes"
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: "#2E315A", alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.keyboardAppearance = .dark
        searchController.obscuresBackgroundDuringPresentation = false
        let searchBarTextField = searchController.searchBar.value(forKey: "searchField") as! UITextField
        let searchIconView = searchBarTextField.leftView as? UIImageView
        searchIconView?.image = searchIconView?.image?.withRenderingMode(.alwaysTemplate)
        searchIconView?.tintColor = .lightGray
        searchBarTextField.textColor = .white
    }
    
    private func interface() {
        tableView.addSubview(backgroundGradient)
        backgroundGradient.frame = tableView.frame
        backgroundGradient.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundGradient
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterNotes(searchBarText: searchController.searchBar.text!)
    }
    
    private func filterNotes(searchBarText: String, scope: String = "All") {
        filteredNotes = notes.filter({ note in
            return note.title!.lowercased().contains(searchBarText.lowercased())
        })
        tableView.reloadData()
    }
    
    func popUpNoteId(_ id: Notes) {
        let savedPassword = NotesVC()
        savedPassword.noteId = id
        savedPassword.modalPresentationStyle = .popover
        present(savedPassword, animated: true, completion: nil)
    }
}
