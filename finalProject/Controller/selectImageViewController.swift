//
//  selectImageViewViewController.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 11/19/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

import UIKit

//define global variable for the current picture selected
var drawingColor = UIColor.black
var lineSize = 3.0
var selected = false

struct imageInfo {
    var name : String
    var isColorByNumber : Bool
    var isFreeDraw : Bool
    var tag: Int
}

var selectedImage = imageInfo.init(name: "rainbowNumbers", isColorByNumber: true, isFreeDraw: false, tag: 0)

class selectImageViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var freeColorCollection: UICollectionView!
    @IBOutlet weak var colorNumberCollection: UICollectionView!
    let cModel = colorModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorNumberCollection.layer.cornerRadius = 20
        freeColorCollection.layer.cornerRadius = 20
        
        /*
        if selected{
            var cell = colorNumberCollection.cellForItem(at: IndexPath(row: previousImageChoice, section: 0))
            
            if previousImageChoice<cModel.numberOfColorNumber(){
                cell = colorNumberCollection.cellForItem(at: IndexPath(row: previousImageChoice, section: 0))
            }
            else{
                cell = freeColorCollection.cellForItem(at: IndexPath(row: previousImageChoice-cModel.numberOfColorNumber(), section: 0))
            }
            
            cell?.layer.borderWidth = 0.0
        }*/
        
        selected = true
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == freeColorCollection {
            return cModel.numberOfFreeColor()
        } else {
            return cModel.numberOfColorNumber()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == colorNumberCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! nextImageCollectionViewCell
            let imgName = cModel.colorByNumberNameArray()[indexPath.row]
            cell.tag = indexPath.row
            cell.setImage(name: imgName)
            cell.imageButton.imageView?.contentMode = .scaleAspectFit
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! nextImageCollectionViewCell
            cell.setImage(name: cModel.freeColorImageAtIndex(at: indexPath.row))
            cell.tag = indexPath.row + cModel.numberOfColorNumber()
            cell.imageButton.imageView?.contentMode = .scaleAspectFit
             return cell
        }
    }
    
    //we need to know what was selected
    @IBAction func selectImage(_ sender: Any) {
        
        /*
        if selected{
            var cell = colorNumberCollection.cellForItem(at: IndexPath(row: 0, section: 0))
            
            if previousImageChoice<cModel.numberOfColorNumber(){
                cell = colorNumberCollection.cellForItem(at: IndexPath(row: previousImageChoice, section: 0))
            }
            else{
                cell = freeColorCollection.cellForItem(at: IndexPath(row: previousImageChoice-cModel.numberOfColorNumber(), section: 0))
            }
            imageSelectCollectionViewCell.selectImage(cell as! imageSelectCollectionViewCell)
            
            //cell?.layer.borderWidth = 0.0
        }*/

        var cell = colorNumberCollection.cellForItem(at: IndexPath(row: previousImageChoice, section: 0))
        
        if previousImageChoice<cModel.numberOfColorNumber(){
            cell = colorNumberCollection.cellForItem(at: IndexPath(row: previousImageChoice, section: 0))
        }
        else{
            cell = freeColorCollection.cellForItem(at: IndexPath(row: previousImageChoice-cModel.numberOfColorNumber(), section: 0))
        }
        
        cell?.layer.borderWidth = 0.0
    }
    
    @IBAction func pressSelect(_ sender: Any) {
        drawingColor = UIColor.black
    }
    
    @IBAction func freeDrawPressed(_ sender: Any) {
        selectedImage.isFreeDraw = true
        selectedImage.isColorByNumber = false
    }
}
