//
//  canvasViewSinglePlayer.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 11/19/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

import UIKit

var score = 0.0
var previousImageChoice = 0

class canvasViewSinglePlayer: UIView {

    var lineColor: UIColor!
    var lineWidth: CGFloat!
    var path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 0, height: 0))
    var touchPoint:CGPoint!
    var startingPoint:CGPoint!
    var lionEar = [CGPoint]()
    var pinkArray = [CGPoint]()
    let cModel = colorModel.sharedInstance
    var shapeLayerArray:[CAShapeLayer] = []
    
    //var lastLayer: CAShapeLayer?
    
    //var shapeLayer = CAShapeLayer()
    var correctTouch = 0
    var totalTouch = 0

    
    //initialize these properties, we don't expect them to be nil
    override func layoutSubviews() {
        
        //when we lay out the view, call this function
        
        //only draw inside the view
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        
        lineColor = drawingColor

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)
        
         if isErasing{
            drawingColor = backGroundColor
         }

    }
    
    @IBAction func pressButton(_ sender: Any) {
        print(lionEar)
    }
 
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        touchPoint = touch?.location(in: self)

        if isErasing{
            drawingColor = backGroundColor
        }
        
        //lionEar.append(touchPoint)

        /* Strategy Two: For pictures with rounded bounds, color inthe picture and maintain an array of all of the points where there should be a certain color. Then, compare the drawn point to the array. The array is too large and will not compile in the model file.*/
        
        //we need to check for correctness
        if selectedImage.isColorByNumber{
            totalTouch += 1
            if (selectedImage.name == "butterflyNumbers"){
                
                if drawingColor == UIColor.brown && cModel.butterflyIsBrown(at: touchPoint){
                    correctTouch += 1
                }
                else if drawingColor == UIColor.black && cModel.butterflyIsBlack(at: touchPoint){
                    correctTouch += 1
                }
                    
                else if(drawingColor == UIColor.magenta && cModel.butterflyIsPink(at: touchPoint)){
                    correctTouch += 1
                }
                else if (drawingColor == UIColor.orange && cModel.butterflyIsOrange(at: touchPoint)){
                   correctTouch += 1
                }
            }
            else if (selectedImage.name == "rainbowNumbers"){
                if (drawingColor == UIColor.red && cModel.rainbowIsRed(at: touchPoint)){
                    correctTouch += 1
                }
                else if (drawingColor == UIColor.green && cModel.rainbowIsGreen(at: touchPoint)){
                    correctTouch += 1
                }
                else if (drawingColor == UIColor.orange && cModel.rainbowIsOrange(at: touchPoint)){
                    correctTouch += 1
                }
                else if (drawingColor == UIColor.blue && cModel.rainbowIsBlue(at: touchPoint)){
                    correctTouch += 1
                }
                else if (drawingColor == UIColor.yellow && cModel.rainbowIsYellow(at: touchPoint)){
                    correctTouch += 1
                }
            }
            else{
                if (drawingColor == UIColor.red && cModel.cupcakeIsRed(at: touchPoint)){
                    correctTouch += 1
                }
                else if (drawingColor == UIColor.magenta && cModel.cupcakeIsPink(at: touchPoint)){
                    correctTouch += 1
                }
                else if (drawingColor == UIColor.brown && cModel.cupcakeIsBrown(at: touchPoint)){
                    correctTouch += 1
                }
                else if (drawingColor == UIColor.green && cModel.cupcakeIsGreen(at: touchPoint)){
                    correctTouch += 1
                }
            }
            
            score = Double(correctTouch)/Double(totalTouch)

        }
    

        //-----------------------------------
        
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: touchPoint)
        startingPoint = touchPoint
        
        drawShape()
        
    }
    
    func returnPinkArray() -> [CGPoint]{
        return pinkArray
    }
    
    func drawShape(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = drawingColor.cgColor
        shapeLayer.lineWidth = CGFloat(lineSize)
        shapeLayer.fillColor = UIColor.clear.cgColor
        //lastLayer = shapeLayer
        shapeLayerArray.append(shapeLayer)
        self.layer.addSublayer(shapeLayer)
        
        //**************************
        
        self.setNeedsDisplay() //the entire bounds will be redrawn after the shape is done being drawn
        
    }
    
    func clearCanvas(){
        
        path.removeAllPoints()
        
        for layer in shapeLayerArray{
            layer.removeFromSuperlayer()
        }
        
        totalTouch = 1
        correctTouch = 0
        
        shapeLayerArray = []
        //we only want to get rid of the sublayers we drew, not the sub layers that make up the view or it crashes
        self.setNeedsDisplay()
    }
}
