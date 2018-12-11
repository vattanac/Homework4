//
//  ViewController.swift
//  HW4
//
//  Created by Vattanac on 12/10/18.
//  Copyright © 2018 vattanac. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITextViewDelegate, UICollectionViewDelegate , UICollectionViewDataSource {
    

    
    @IBOutlet weak var collectionview: UICollectionView!

    var placeholderLabel : UILabel!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var noteList = [Note]()
    lazy var context = appDelegate.persistentContainer.viewContext
    
    func getData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for note in result as! [NSManagedObject]{
                noteList.append(note as! Note)
                print("######\(note)")
                appDelegate.saveContext()
            }
        }catch{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.delegate = self
        collectionview.dataSource = self
        
        
        var layout = self.collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layout.minimumLineSpacing = 5
        var vec = self.collectionview.frame.size
        layout.itemSize = CGSize(width: (vec.width - 20)/2 , height: vec.height/3)


        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }
    
    @IBAction func Noting(_ sender: Any) {
    
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath) as! CollectionViewCell
        
        return cell
    }

    
    
   
    
   
   
}

