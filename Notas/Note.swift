//
//  Notes.swift
//  Notas
//
//  Created by Jorge Sánchez on 20/9/17.
//  Copyright © 2017 Jorge Sánchez. All rights reserved.
//

import Foundation

class Note {
    
    // MARK: - Properties
    var title: String = ""
    var description: String = ""
    var dateDue: Double?
    
    init(title: String, description: String, dateDue: Double?) {
        self.title = title
        self.description = description
        self.dateDue = dateDue
    }
    
    static func generateNotes() -> [Note]  {
        let note1 = Note(title: "Prueba 1", description: "Nota de prueba número 1", dateDue: 1505911175485)
        
        let note2 = Note(title: "Prueba 2", description: "Nota de prueba número 2", dateDue: 1505911005485)
        
        let note3 = Note(title: "Prueba 3", description: "Nota de prueba número 3", dateDue: 1505001175485)
        
        return [note1, note2, note3]
    }
}
