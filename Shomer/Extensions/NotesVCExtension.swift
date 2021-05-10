//
//  File.swift
//  Shomer
//
//  Created by David T on 5/7/21.
//

import UIKit

extension NotesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive && searchController.searchBar.text != "" ? filteredNotes.count : notes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! NotesTableViewCell
        let color = UIView()
        color.backgroundColor = .clear
        cell.selectedBackgroundView = color
        if searchController.isActive && searchController.searchBar.text != "" {
            let noteId = filteredNotes[indexPath.row]
            cell.note = noteId
        } else {
            let noteId = notes[indexPath.row]
            cell.note = noteId
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            let noteId = filteredNotes[indexPath.row]
            popUpNoteId(noteId)
        } else {
            let noteId = notes[indexPath.row]
            popUpNoteId(noteId)
        }
    }
}
