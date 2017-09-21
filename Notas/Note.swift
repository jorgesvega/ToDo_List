//
//  Notes.swift
//  Notas
//
//  Created by Jorge Sánchez on 20/9/17.
//  Copyright © 2017 Jorge Sánchez. All rights reserved.
//

import UIKit
import CoreData

class Note {
    
    // MARK: - Properties
    var title: String = ""
    var taskInfo: String = ""
    var dateDue: Double?
    
    init(title: String, taskInfo: String, dateDue: Double?) {
        self.title = title
        self.taskInfo = taskInfo
        self.dateDue = dateDue
    }
    
    static func generateNotes() -> [Note]  {
        // Default data
        let note1 = Note(title: "Prueba 1", taskInfo: "Nota de prueba número 1", dateDue: 1505911175485)
        let note2 = Note(title: "Prueba 2", taskInfo: "Nota de prueba número 2", dateDue: 1505911005485)
        let note3 = Note(title: "Prueba 3", taskInfo: "Nota de prueba número 3", dateDue: 1505001175485)
        
        return [note1, note2, note3]
    }
    
    func saveNote() -> Note? {
        
        // CORE DATA
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "NoteCD",
                                       in: managedContext)!
        
        let note = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        note.setValue(self.title, forKeyPath: "noteTitle")
        note.setValue(self.taskInfo, forKeyPath: "noteDescription")
        note.setValue(self.dateDue, forKey: "noteDate")
        
        do {
            try managedContext.save()
            return Note(title: self.title, taskInfo: self.taskInfo, dateDue: self.dateDue)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
    func fetchNotes() -> [Note]? {
            
            //1
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return nil
            }
        
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            //2
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "NoteCD")
            
            //3
            do {
                let noteArrayAsManaged: [NSManagedObject] = try managedContext.fetch(fetchRequest)
                var notesArray: [Note] = []
                for note in noteArrayAsManaged {
//                    notesArray.append((note))
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return nil
            }
    }
}
