//
//  CreatNoteViewController.swift
//  HW4
//
//  Created by Vattanac on 12/10/18.
//  Copyright © 2018 vattanac. All rights reserved.
//

import UIKit
import CoreData
class CreatNoteViewController: UIViewController ,UITextViewDelegate {
    
    @IBOutlet weak var TextFieldFack: UITextView!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var titleTextfield: UITextField!
    
    var Noted:Note!
    var isUpdate = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var  context = appDelegate.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        if isUpdate {
            titleTextfield.text = Noted.title
            TextFieldFack.text = Noted.des
            noteTextField.placeholder = ""
        }
        TextFieldFack.delegate = self
        
        

    }

    func updateNote() {
            Noted.setValue(titleTextfield.text, forKey: "title")
            Noted.setValue(TextFieldFack.text, forKey: "des")
        
            appDelegate.saveContext()
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        noteTextField.placeholder = ""
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if noteTextField.placeholder == ""{
            noteTextField.placeholder = "note"
        }
    }
   
    func saveDate(){
        var note = Note(context: context)
        note.setValue(titleTextfield.text, forKey: "title")
        note.setValue(TextFieldFack.text, forKey: "des")
        
        appDelegate.saveContext()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if isUpdate == true {
            updateNote()
            
        }else{
            saveDate()
        }
    }
    
    
    


}
