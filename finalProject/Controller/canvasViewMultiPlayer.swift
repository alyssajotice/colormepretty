//
//  canvasView.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 11/12/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

import UIKit

class canvasViewMultiPlayer: UIView {
    
    var lineColor: UIColor!
    var lineWidth: CGFloat!
    var touchPoint:CGPoint!
    var startingPoint:CGPoint!
    var path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 0, height: 0))
    var shapeLayerArray:[CAShapeLayer] = []
    //var multiScore = 0
    
    var correctTouch = 0
    var totalTouch = 0
    let cModel = colorModel.sharedInstance
    
    let colorService = ColorService()
    
    //initialize these properties, we don't expect them to be nil
    override func layoutSubviews() {
        
        colorService.delegate = (self as ColorServiceDelegate)
        
        //when we lay out the view, call this function
        
        //only draw inside the view
        self.clipsToBounds = true
        
        self.isMultipleTouchEnabled = false
        
        lineColor = drawingColor
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)

        print(touchPoint)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        
        if isErasing{
            drawingColor = backGroundColor
        }
    
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
            print(score)
            
            //print(String(correctTouch) + "/" + String(totalTouch))
        }
        
        
        //-----------------------------------
        
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: touchPoint)
        startingPoint = touchPoint
        
        drawShape()
        
    }
    
    func drawShape(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = drawingColor.cgColor
        shapeLayer.lineWidth = CGFloat(lineSize)
        shapeLayer.fillColor = UIColor.clear.cgColor

        shapeLayerArray.append(shapeLayer)
        self.layer.addSublayer(shapeLayer)

        colorService.sendShape(newLayer: shapeLayer)
        
        //**************************
        
        self.setNeedsDisplay() //the entire bounds will be redrawn after the shape is done being drawn
        
    }
    
    func clearCanvas(){
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.cyan.cgColor
        
        colorService.sendShape(newLayer: shapeLayer)
        
        totalTouch = 1
        correctTouch = 0
        
        path.removeAllPoints()
        
        for layer in shapeLayerArray{
            layer.removeFromSuperlayer()
        }
        shapeLayerArray = []
        self.setNeedsDisplay()
    }
}

extension canvasViewMultiPlayer : ColorServiceDelegate {
    
    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            //self.deviceLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func colorChanged(manager: ColorService, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                //self.change(color: .red)
                self.backgroundColor = UIColor.red
            case "yellow":
                self.backgroundColor = UIColor.yellow
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }

    func shapeAdded(manager: ColorService, newLayer: CAShapeLayer) {
        OperationQueue.main.addOperation {
            
            if newLayer.strokeColor == UIColor.cyan.cgColor{

                self.path.removeAllPoints()
                print(self.shapeLayerArray)
                
                for layer in self.shapeLayerArray{
                    layer.removeFromSuperlayer()
                }
                self.shapeLayerArray = []
                self.setNeedsDisplay()
            }
            else{
                self.layer.addSublayer(newLayer)
                self.shapeLayerArray.append(newLayer)
            }
        
            self.setNeedsDisplay()
        }
    }
}
