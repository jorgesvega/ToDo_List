//
//  AddNoteView.swift
//  Notas
//
//  Created by Jorge Sánchez on 20/9/17.
//  Copyright © 2017 Jorge Sánchez. All rights reserved.
//

import UIKit
import CoreData

protocol AddNoteViewDelegate {
    func didCancel()
    func didSave(_ note: Note)
}

@IBDesignable class AddNoteView: UIView {
    
    // MARK: - Properties
    var delegate: AddNoteViewDelegate?
    var selectedPickerDate: Double = 0

    // MARK: - IBOutlets
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldDescription: UITextField!
    @IBOutlet var pickerDate: UIDatePicker!
    @IBOutlet var view: UIView!
    
    // MARK: - IBActions
    @IBAction func actionSave(_ sender: Any) {
        save()
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        delegate?.didCancel()
        clearFields()
    }
    
    @IBAction func actionDatePicker(_ sender: UIDatePicker) {
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: (sender as AnyObject).date)
        
        selectedPickerDate = sender.date.timeIntervalSince1970
        
        print("Selected value \(selectedDate)")
    }

    // MARK: - Lifecycle methods
    //MARK: - Init methods
    // The init(frame:) version is the default initializer. You must call it only after initializing your instance variables.
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = loadViewFromNib()
    }
    
    // If this view is being reconstituted from a Nib then your custom initializer will not be called, and instead the init?(coder:) version will be called
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = loadViewFromNib()
    }
    
    func delegate (_ delegate: AddNoteViewDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Private methods
    fileprivate func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName(), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
    
    fileprivate func nibName() -> String {
        return String(describing: type(of: self))
    }
    
    fileprivate func save() {
        guard let titleData: String = textFieldTitle.text,
            let descriptionData: String = textFieldDescription.text,
            !titleData.isEmpty,
            !descriptionData.isEmpty else {
                print("Error: Faltan campos")
                return
        }
        
        let createdNote: Note = Note(title: titleData, taskInfo: descriptionData, dateDue: selectedPickerDate)
        
        delegate?.didSave(createdNote.saveNote() ?? Note(title: "error", taskInfo: "error", dateDue: nil))
        
        clearFields()
    }
    
    fileprivate func clearFields() {
        textFieldTitle.text = ""
        textFieldDescription.text = ""
    }
    
    @IBInspectable dynamic var borderColor: UIColor = UIColor.green {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable dynamic var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable dynamic var radius: CGFloat = 6 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
}
