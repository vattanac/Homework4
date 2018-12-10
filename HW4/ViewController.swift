//
//  ViewController.swift
//  HW4
//
//  Created by Vattanac on 12/10/18.
//  Copyright © 2018 vattanac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UICollectionViewDelegate , UICollectionViewDataSource {
    

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var textView: UITextView!
    var placeholderLabel : UILabel!
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath) as! UICollectionViewCell
        return cell
    }
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 10), height: CGFloat(100))
//    }
    
    
    
   
}

