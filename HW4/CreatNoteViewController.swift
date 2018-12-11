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
    
    //Textview as like Textfield for write Note Description
    @IBOutlet weak var TextFieldFack: UITextView!
    //Textfiedl that behide Textview
    @IBOutlet weak var noteTextField: UITextField!
    //Textfield write  Note Title
    @IBOutlet weak var titleTextfield: UITextField!
    
    var Noted:Note!
    var isUpdate = false
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var  context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get previous data frome each Note
        if isUpdate {
            titleTextfield.text = Noted.title
            TextFieldFack.text = Noted.des
            noteTextField.placeholder = ""
        }
        TextFieldFack.delegate = self
    }
    
    //function update Note
    func updateNote() {
            Noted.setValue(titleTextfield.text, forKey: "title")
            Noted.setValue(TextFieldFack.text, forKey: "des")
            appDelegate.saveContext()
    }
    
    //Alert on TabbarbuttonItem
    @IBAction func LeftTabbarItem(_ sender: Any) {
        let alert = UIAlertController(title: "tools", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Chose image", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Drawing", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Recording", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Checkbox", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func RightTabbarItem(_ sender: Any) {
        
        let alert = UIAlertController(title: "Message", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Make a copy", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Collabrators", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Label", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //custome Textview as like textfield
    func textViewDidBeginEditing(_ textView: UITextView) {
        noteTextField.placeholder = ""
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if noteTextField.placeholder == ""{
            noteTextField.placeholder = "note"
        }
    }
   
    //Save data to Coredata
    func saveDate(){
        var note = Note(context: context)
        note.setValue(titleTextfield.text, forKey: "title")
        note.setValue(TextFieldFack.text, forKey: "des")
        
        appDelegate.saveContext()
    }
    
    //Study on condition click cell to update
    override func viewWillDisappear(_ animated: Bool) {
        if isUpdate == true {
            updateNote()
            
        }else{
            saveDate()
        }
    }
}
