//
//  nextImageCollectionViewCell.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 12/9/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

import UIKit

class nextImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageButton: UIButton!
    let cModel = colorModel.sharedInstance
    var borderRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    func setImage(name: String){
        let img = UIImage(named: name)
        imageButton.setImage(img, for: UIControl.State.normal)
        imageButton.imageView?.contentMode = .scaleAspectFit
        
        
        //borderRect = getFrameSizeForImage(image: UIImage(named: name)!, imageView: imageButton.imageView!)
        
        /* var imageViewFrame = CGRect((imageButton.imageView?.frame.origin.x)! + borderRect.origin.x, (imageButton.imageView?.frame.origin.y)! + borderRect.origin.y, borderRect.size.width, borderRect.size.height);
         imageButton.imageView?.frame = imageViewFrame;*/
        
        if name == "rainbowNumbers"{
            self.layer.borderColor = #colorLiteral(red: 0.9671540856, green: 0.6349585652, blue: 0.7611256242, alpha: 1)
            self.layer.borderWidth = 7.0
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
        
        previousImageChoice = self.tag
        
        self.layer.borderColor = #colorLiteral(red: 0.9671540856, green: 0.6349585652, blue: 0.7611256242, alpha: 1)
        self.layer.borderWidth = 7.0
        
        if (self.tag) < cModel.numberOfColorNumber(){
            selectedImage.name = cModel.imageAtColorTag(at: self.tag)
            selectedImage.isColorByNumber = true
        }
        else{
            selectedImage.name = cModel.freeColorImageAtIndex(at: self.tag-cModel.numberOfColorNumber())
            selectedImage.isColorByNumber = false
        }
        selectedImage.isFreeDraw = false
    }
    
    func getFrameSizeForImage(image: UIImage, imageView: UIImageView) -> CGRect {
        
        let hfactor = image.size.width / imageView.frame.size.width
        let vfactor = image.size.height / imageView.frame.size.height
        
        let factor = fmax(hfactor, vfactor)
        
        let newWidth = image.size.width / factor
        let newHeight = image.size.height / factor
        
        let leftOffset = (imageView.frame.size.width - newWidth) / 2;
        let topOffset = (imageView.frame.size.height - newHeight) / 2;
        
        return CGRect(x: leftOffset, y: topOffset, width: newWidth, height: newHeight)
    }
    
    
}
