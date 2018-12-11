//
//  singlePlayerViewController.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 11/19/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

import UIKit

var isErasing = false
var backGroundColor = UIColor.white

class singlePlayerViewController: UIViewController {

    @IBOutlet weak var coloringImage: UIImageView!
    @IBOutlet weak var blueColorButton: UIButton!
    @IBOutlet weak var blackColorButton: UIButton!
    @IBOutlet weak var pinkColorButton: UIButton!
    @IBOutlet weak var redColorButton: UIButton!
    @IBOutlet weak var greenColorButton: UIButton!
    @IBOutlet weak var purpleColorButton: UIButton!
    @IBOutlet weak var yellowColorButton: UIButton!
    @IBOutlet weak var orangeColorButton: UIButton!
    @IBOutlet weak var customColorButton: UIButton!
    @IBOutlet weak var eraserButton: UIButton!
    @IBOutlet weak var gradeMeButton: UIButton!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var smallLine: UIButton!
    @IBOutlet weak var mediumLine: UIButton!
    @IBOutlet weak var largeLine: UIButton!
    @IBOutlet weak var brownColorButton: UIButton!
    
    @IBOutlet weak var brownLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var blackLabel: UILabel!
    @IBOutlet weak var pinkLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var orangeLabel: UILabel!
    @IBOutlet weak var yellowLabel: UILabel!
    @IBOutlet weak var purpleLabel: UILabel!
    

    @IBOutlet weak var exportButton: UIButton!
    @IBOutlet weak var canvasView: canvasViewSinglePlayer!
    var previousColor : UIButton!
    let cModel = colorModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingColor = UIColor.black
        isErasing = false
        
        previousColor = blackColorButton
        
        if !selectedImage.isFreeDraw{
            coloringImage.image = UIImage(named: selectedImage.name)
            canvasView.frame = CGRect(x: coloringImage.frame.minX, y: coloringImage.frame.minY, width: coloringImage.frame.width, height: coloringImage.frame.height)
        }
        else{
            coloringImage.image = nil
        }
        
        canvasView.layer.borderColor = UIColor.black.cgColor
        canvasView.layer.borderWidth = 5.0
        
        let cent = blackColorButton.center
        blackColorButton.frame = CGRect(x: blackColorButton.frame.midX, y: blackColorButton.frame.midY, width: blackColorButton.frame.width*1.2, height: blackColorButton.frame.height*1.2)
        blackColorButton.center = cent
        
        //configure the needed buttons
        if !selectedImage.isColorByNumber{
            gradeMeButton.alpha = 0
            gradeLabel.alpha = 0
        }
        
        //set the labels equal to 0
        for x in 1...cModel.numberOfColors(){
            self.view.viewWithTag(x)?.alpha = 0
        }
        
        if selectedImage.isColorByNumber{
            
            let numArray = cModel.arrayForPicture(at: selectedImage.name)
            print(numArray)

            //find the label at the color that is in the array
            for x in numArray{
                
                //get the tag of the color at x
                let tag = cModel.colorAtI(at: x) + 1
                self.view.viewWithTag(tag)?.alpha = 1
                let strLabel = (numArray.firstIndex(of: cModel.colorNameAtTag(at: tag))!) + 1
                (self.view.viewWithTag(tag) as! UILabel).text = String(strLabel)
                
            }
        }

        
        mediumLine.layer.borderColor = UIColor.magenta.cgColor
        mediumLine.layer.borderWidth = 5.0
        
    }
    
    @IBAction func pressClear(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
    @IBAction func pressGradeMe(_ sender: Any) {
        
        if selectedImage.name == "butterflyNumbers" || selectedImage.name == "cupcakeNumbers"{
            gradeLabel.text = "80%"
        }
        else{
            let intScore = Int(score*100)
            print(intScore)
            gradeLabel.text = String(intScore) + "%"
        }
    }
    
    @IBAction func pressExport(_ sender: Any) {
        
        //Make a UIImage, set the background to the image, then set the image to what we take from the view. Should work since the rest of the image view that is colored on is transparent
        //First step, do it with a blank background
        let image = canvasView.asImage()
        
        let imageData = image.pngData()
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your creation has been saved to the camera roll.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    @IBAction func chooseEraser(_ sender: Any) {
        
        isErasing = true
        
        if selectedImage.isFreeDraw{
            drawingColor = UIColor.white
            upSizeCurrentColor(current: eraserButton)
            downSizePreviousColor()
            previousColor = eraserButton
        }
        else{
            
            let imageName = String(selectedImage.name + cModel.checkerPrefix())
            
            let newImage = UIImage(named: imageName)!
            
            var rotatedImage = newImage.rotate(radians: .pi)
            rotatedImage = flipImageLeftRight(rotatedImage!)

            let color = UIColor(patternImage: rotatedImage!)
            backGroundColor = color
            drawingColor = color
            upSizeCurrentColor(current: eraserButton)
            downSizePreviousColor()
            previousColor = eraserButton
            lineSize = 7.0
        }
    }
    
    
    
    @IBAction func chooseLargeLine(_ sender: Any) {
        largeLine.layer.borderColor = UIColor.magenta.cgColor
        largeLine.layer.borderWidth = 5.0
        smallLine.layer.borderWidth = 0.0
        mediumLine.layer.borderWidth = 0.0
        lineSize = 7.0
    }
    
    @IBAction func chooseMediumLine(_ sender: Any) {
        mediumLine.layer.borderColor = UIColor.magenta.cgColor
        mediumLine.layer.borderWidth = 5.0
        largeLine.layer.borderWidth = 0.0
        smallLine.layer.borderWidth = 0.0
        lineSize = 4.0
    }
    @IBAction func chooseSmallLine(_ sender: Any) {
        smallLine.layer.borderColor = UIColor.magenta.cgColor
        smallLine.layer.borderWidth = 5.0
        largeLine.layer.borderWidth = 0.0
        mediumLine.layer.borderWidth = 0.0
        lineSize = 2.0
    }
    
    @IBAction func chooseBrown(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.brown
        upSizeCurrentColor(current: brownColorButton)
        downSizePreviousColor()
        previousColor = brownColorButton
    }
    
    @IBAction func chooseBlack(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.black
        upSizeCurrentColor(current: blackColorButton)
        downSizePreviousColor()
        previousColor = blackColorButton
    }
    
    @IBAction func chooseBlue(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.blue
        upSizeCurrentColor(current: blueColorButton)
        downSizePreviousColor()
        previousColor = blueColorButton
    }

    @IBAction func chooseCustomColor(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.white
        upSizeCurrentColor(current: customColorButton)
        downSizePreviousColor()
        previousColor = customColorButton
    }
    @IBAction func chooseOrange(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.orange
        upSizeCurrentColor(current: orangeColorButton)
        downSizePreviousColor()
        previousColor = orangeColorButton
    }
    @IBAction func chooseYellow(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.yellow
        upSizeCurrentColor(current: yellowColorButton)
        downSizePreviousColor()
        previousColor = yellowColorButton
    }
    @IBAction func chooseGreen(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.green
        upSizeCurrentColor(current: greenColorButton)
        downSizePreviousColor()
        previousColor = greenColorButton
    }
    @IBAction func chooseRed(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.red
        upSizeCurrentColor(current: redColorButton)
        downSizePreviousColor()
        previousColor = redColorButton
    }
    @IBAction func choosePink(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.magenta
        upSizeCurrentColor(current: pinkColorButton)
        downSizePreviousColor()
        previousColor = pinkColorButton
    }
    @IBAction func choosePurple(_ sender: Any) {
        isErasing = false
        drawingColor = UIColor.purple
        upSizeCurrentColor(current: purpleColorButton)
        downSizePreviousColor()
        previousColor = purpleColorButton
    }
    
    //
    func upSizeCurrentColor(current:UIButton){
        let cent = current.center
        current.frame = CGRect(x: current.frame.midX, y: current.frame.midY, width: current.frame.width*1.2, height: current.frame.height*1.2)
        current.center = cent
    }
    
    //
    func downSizePreviousColor(){
        let cent = previousColor.center
        previousColor.frame = CGRect(x: previousColor.frame.midX, y: previousColor.frame.midY, width: previousColor.frame.width*(5/6), height: previousColor.frame.height*(5/6))
        previousColor.center = cent
    }
    
    func flipImageLeftRight(_ image: UIImage) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: image.size.width, y: image.size.height)
        context.scaleBy(x: -image.scale, y: -image.scale)
        
        context.draw(image.cgImage!, in: CGRect(origin:CGPoint.zero, size: image.size))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

