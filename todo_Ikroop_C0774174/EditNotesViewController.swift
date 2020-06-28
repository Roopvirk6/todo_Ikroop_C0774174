//
//  ViewController.swift
//  todo_Ikroop_C0774174
//
//  Created by VirkIkroop on 2020-06-24.
//  Copyright © 2020 VirkIkroop. All rights reserved.
//

import UIKit
import CoreData

class EditNotesViewController: UIViewController {
    
    
    
    @IBOutlet weak var title_txt: UITextField!
    
    
    @IBOutlet weak var description_txt: UITextView!
    
    
    @IBOutlet weak var days_txt: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
    
    
    var note: Note!
          var notebook : Notebook?
          var userIsEditing = true
    // MARK: -- database
        var context:NSManagedObjectContext!
    
    
    @IBOutlet weak var btnDate: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        // Do any additional setup after loading the view.
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            context = appDelegate.persistentContainer.viewContext
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        
        self.view.addGestureRecognizer(tapGesture)
        
        
        
        
        }
    func showDatePicker()
    {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton], animated: false)
        btnDate.inputAccessoryView = toolbar
        btnDate.inputView = datePicker
    }
    @objc func doneDatePicker()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        btnDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker()
    {
        self.view.endEditing(true)
    }
    
    
    
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {        description_txt.resignFirstResponder()
        days_txt.resignFirstResponder()
        title_txt.resignFirstResponder()
    }
    
    
    @IBAction func addTaskBtn(_ sender: UIButton)
    {
        if (description_txt.text!.isEmpty) {
                  print("Please enter some text")
                  return
              }
              
              
              if (userIsEditing == true) {
                  //note.text = description_txt.text!
              
                  
                  // create a new task 
                  self.note = Note(context:context)
                  note.setValue(Date(), forKey:"dateAdded")
                  if (title_txt.text!.isEmpty) {
                      note.title = "No Title"
                  }
                  else{
                      note.title = title_txt.text!
                  }
                  note.text = description_txt.text!
                note.days = Int16(days_txt.text!) ?? 0
                
               
                 
                  note.notebook = self.notebook
              }
              
              do {
                  try context.save()
                  print("Task Saved!")
                  
                  
                  // show an alert box
                  let alertBox = UIAlertController(title: "Saved!", message: "Save Successful.", preferredStyle: .alert)
                  alertBox.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                  self.present(alertBox, animated: true, completion: nil)
              }
              catch {
                  print("Error saving Task in Edit Task screen")
                  
                  // show an alert box with an error message
                  let alertBox = UIAlertController(title: "Error", message: "Error while saving.", preferredStyle: .alert)
                  alertBox.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                  self.present(alertBox, animated: true, completion: nil)
              }
              if (userIsEditing == false) {
                  self.navigationController?.popViewController(animated: true)
                  //self.dismiss(animated: true, completion: nil)
              }
              
        
        
    }
    
    
    
    }
    
    




