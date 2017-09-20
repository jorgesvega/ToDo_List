//
//  NotesVC.swift
//  Notas
//
//  Created by Jorge Sánchez on 20/9/17.
//  Copyright © 2017 Jorge Sánchez. All rights reserved.
//

import UIKit

class NotesVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewAddNoteView: AddNoteView!
    
    // MARK: - IBActions
    @IBAction func actionAddNote(_ sender: Any) {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.viewAddNoteView.frame = CGRect(x: 0,
                                                y: self.view.frame.size.height - self.viewAddNoteView.frame.size.height - 50,
                                                width: self.viewAddNoteView.frame.size.width,
                                                height: self.viewAddNoteView.frame.size.height)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: - Properties
    var cellIdentifier = "prototypeCell"
    var notesArray: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        initializeData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Configure methods
    fileprivate func configureViews() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        viewAddNoteView.frame = CGRect(x: 0,
                                       y: self.view.frame.size.height,
                                       width: self.view.frame.size.width,
                                       height: viewAddNoteView.frame.size.height)
    }
    
    fileprivate func initializeData() {
        self.viewAddNoteView.delegate = self
        notesArray = Note.generateNotes()
        self.tableView.reloadData()
    }

}

extension NotesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let note = notesArray[indexPath.row]
        cell.textLabel?.text = note.title
        return cell
    }
}

extension NotesVC: AddNoteViewDelegate{
    
    func didCancel() {
        print("CANCEL")
    }
    
    func didSave(_ note: Note) {
        print("SAVE")
        
        notesArray.append(note)
        tableView.reloadData()
    }
    
}
