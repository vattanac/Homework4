//
//  ViewController.swift
//  HW4
//
//  Created by Vattanac on 12/10/18.
//  Copyright © 2018 vattanac. All rights reserved.
//

import UIKit
import CoreData

//start classs
class ViewController: UIViewController, UITextViewDelegate, UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var dumyTextfield: UITextField!
    
    var placeholderLabel : UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var noteList = [Note]()
    lazy var context = appDelegate.persistentContainer.viewContext
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        noteList = [Note]()
        getData()
        collectionview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        collectionview.delegate = self
        collectionview.dataSource = self
        
        //make CollectionCiewCell look nicer
        var layout = self.collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layout.minimumLineSpacing = 5
        var vec = self.collectionview.frame.size
        layout.itemSize = CGSize(width: (vec.width - 20)/2 , height: vec.height/3)
        
        
         //custome NavigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Create Guesture for Click On CollectionCiewCell
        let guesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleGuesture))
        
        guesture.minimumPressDuration = 0.3
        guesture.delegate = self
        guesture.delaysTouchesBegan = true
        self.collectionview.addGestureRecognizer(guesture)
        
        //Creat Guesture for Textfield in TabarItem
        dumyTextfield.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTextFieldTap))
      
        )
    }
    
    //function get Data and add to Arraylist
    func getData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for note in result as! [NSManagedObject]{
                noteList.append(note as! Note)
                //print("######\(note)")
                appDelegate.saveContext()
            }
        }catch{
            
        }
    }
    @IBAction func Noting(_ sender: Any) {
        
        
    }
    
    //creat collectionviewcell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noteList.count
    }
    
    //set data to each collectionviewcell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath) as! CollectionViewCell
        
        cell.titleLabel.text = noteList[indexPath.row].title
        cell.desLabel.text = noteList[indexPath.row].des
        
        return cell
    }
    
    //condition when click collectionviewcell to update and current value on Note
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let creatNote = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "create") as! CreatNoteViewController
        creatNote.Noted = noteList[indexPath.row]
        creatNote.isUpdate = true
        navigationController?.pushViewController(creatNote, animated: true)
        
       
        
    }
    
    //function Delete Note By index of collectionviewcell
    func DeleteNote(indexPath:IndexPath){
        let alert = UIAlertController(title: "Are you sure to delete?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action:UIAlertAction!) in
            self.context.delete(self.noteList[indexPath.row])
            self.noteList.remove(at: indexPath.row)
            self.collectionview.deleteItems(at: [indexPath])
            self.collectionview.reloadData()
            self.appDelegate.saveContext()
        }))
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         self.present(alert, animated: true, completion: nil)
    }
    
}//End class


//Extend for Guesture
extension ViewController:UIGestureRecognizerDelegate{
    
    //handle guesture for click CollectionViewCell
    @objc func handleGuesture(guesturer:UILongPressGestureRecognizer){
        if(guesturer.state != UIGestureRecognizer.State.ended){
            return
        }
        let gestureLocate = guesturer.location(in: self.collectionview)
        if let indexPath: IndexPath = (self.collectionview.indexPathForItem(at: gestureLocate)){
            DeleteNote(indexPath: indexPath)
        }
    }
    
    //handle Textfield In Tabbar
    @objc func handleTextFieldTap(){
        let creteNoteVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "create") as! CreatNoteViewController
        navigationController?.pushViewController(creteNoteVC, animated: true)
    }
}

