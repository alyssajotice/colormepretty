//
//  colorModel.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 11/23/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class colorModel{
    
    static let sharedInstance = colorModel()

    typealias Points  = [[Double]]
    typealias LionPoints = [CGPoint]
    
    //var lionPoints : LionPoints
    var BrownButterfly : LionPoints
    var BlackButterfly : LionPoints

    var RedRainbow : LionPoints
    var BlueRainbow : LionPoints
    var YellowRainbow : LionPoints
    var GreenRainbow : LionPoints
    var OrangeRainbow : LionPoints
    
    
    var PinkButterfly : LionPoints
    var OrangeButterfly : LionPoints
    
    var BrownCupcake : LionPoints
    var GreenCupcake : LionPoints
    var RedCupcake : LionPoints
    var PinkCupcake : LionPoints
    
    
    let d = (2.4,4.5)
    
    let colorByNumberPictures : [String]
    let freeColorPictures : [String]
    let butterflyNumbersNeeded: [String]
    let cupcakeNumbersNeeded: [String]
    let raindbowNumbersNeeded: [String]
    let orderOfColors: [String]
    var prefix: String
    
    init() {
        
        colorByNumberPictures = ["rainbowNumbers", "butterflyNumbers", "cupcakeNumbers"]
        freeColorPictures = ["puppy", "ballgown", "princess", "unicorn","kitten", "minnie"]
        butterflyNumbersNeeded = ["black", "brown", "pink", "orange"]
        cupcakeNumbersNeeded = ["pink", "brown", "red", "green"]
        raindbowNumbersNeeded = ["red", "green", "orange", "blue", "yellow"]
        orderOfColors = ["brown", "blue", "black", "pink", "red", "green", "purple", "yellow", "orange", "white"]
        prefix = "Walkthrough"
        
        let bundle = Bundle.main
        //let path = bundle.path(forResource: "LionPoints", ofType: "json")!
        let brownButterflyPath = bundle.path(forResource: "butterflyBrown", ofType: "json")!
       // let url = URL(fileURLWithPath: path)
        let brownButterflyURL = URL(fileURLWithPath: brownButterflyPath)
        
        let blackButterflyPath = bundle.path(forResource: "butterflyBlack", ofType: "json")!
        let blackButterflyURL = URL(fileURLWithPath: blackButterflyPath)
        
        //Rainbow jsons
        let redRainbowPath = bundle.path(forResource: "rainbowRed", ofType: "json")!
        let redRainbowURL = URL(fileURLWithPath: redRainbowPath)
        
        let orangeRainbowPath = bundle.path(forResource: "rainbowOrange", ofType: "json")!
        let orangeRainbowURL = URL(fileURLWithPath: orangeRainbowPath)
        
        
        let yellowRainbowPath = bundle.path(forResource: "rainbowYellow", ofType: "json")!
        let yellowRainbowURL = URL(fileURLWithPath: yellowRainbowPath)
        
        
        let greenRainbowPath = bundle.path(forResource: "rainbowGreen", ofType: "json")!
        let greenRainbowURL = URL(fileURLWithPath: greenRainbowPath)
        
        
        let blueRainbowPath = bundle.path(forResource: "rainbowBlue", ofType: "json")!
        let blueRainbowURL = URL(fileURLWithPath: blueRainbowPath)
        
       
        /*
        let pinkButterflyPath = bundle.path(forResource: "butterflyPink", ofType: "json")!
        let pinkButterflyURL = URL(fileURLWithPath: pinkButterflyPath)
        
        let orangeButterflyPath = bundle.path(forResource: "butterflyOrange", ofType: "json")!
        let orangeButterflyURL = URL(fileURLWithPath: orangeButterflyPath)
        
        let brownCupcakePath = bundle.path(forResource: "cupcakeBrown", ofType: "json")!
        let brownCupcakeURL = URL(fileURLWithPath: brownCupcakePath)
        
        let greenCupcakePath = bundle.path(forResource: "cupcakeGreen", ofType: "json")!
        let greenCupcakeURL = URL(fileURLWithPath: greenCupcakePath)
        
        let redCupcakePath = bundle.path(forResource: "cupcakeRed", ofType: "json")!
        let redCupcakeURL = URL(fileURLWithPath: redCupcakePath)
        
        let pinkCupcakePath = bundle.path(forResource: "cupcakePink", ofType: "json")!
        let pinkCupcakeURL = URL(fileURLWithPath: pinkCupcakePath)
        */
 
 
        do {
            
            var data = try Data.init(contentsOf: brownButterflyURL)
            var decoder = JSONDecoder()
            var points = try decoder.decode(Points.self, from: data)
            
            BrownButterfly = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            
            data = try Data.init(contentsOf: blackButterflyURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            BlackButterfly = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            /*
            
            data = try Data.init(contentsOf: pinkButterflyURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            PinkButterfly = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            
            data = try Data.init(contentsOf: orangeButterflyURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            OrangeButterfly = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })*/
            
            
            
            data = try Data.init(contentsOf: redRainbowURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            RedRainbow = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            
            
            data = try Data.init(contentsOf: greenRainbowURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            GreenRainbow = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            
            
            data = try Data.init(contentsOf: orangeRainbowURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            OrangeRainbow = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            
            
            
            data = try Data.init(contentsOf: blueRainbowURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            BlueRainbow = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            
            
            
            data = try Data.init(contentsOf: yellowRainbowURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            YellowRainbow = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
        
            PinkButterfly = []
            OrangeButterfly = []
            PinkCupcake = []
            RedCupcake = []
            BrownCupcake = []
            GreenCupcake = []
            
            /*
            data = try Data.init(contentsOf: brownCupcakeURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            BrownCupcake = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            
            data = try Data.init(contentsOf: pinkCupcakeURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            PinkCupcake = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            
            data = try Data.init(contentsOf: greenCupcakeURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            GreenCupcake = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
            
            data = try Data.init(contentsOf: redCupcakeURL)
            decoder = JSONDecoder()
            points = try decoder.decode(Points.self, from: data)
            
            RedCupcake = points.map({ (dd) -> CGPoint in
                (CGPoint(x: dd[0], y: dd[1]))
            })
             */
            
        } catch {
            print("Error")
            print("error: \(error.localizedDescription)")
            BrownButterfly = []
            BlackButterfly = []
            PinkButterfly = []
            OrangeButterfly = []
            RedRainbow = []
            OrangeRainbow = []
            GreenRainbow = []
            YellowRainbow = []
            BlueRainbow = []
            RedCupcake = []
            GreenCupcake = []
            BrownCupcake = []
            PinkCupcake = []
            prefix = ""
        }
    }
    
    //Given the name of a picture and the index of the label we are on, return true or false for if we need the label
    func arrayForPicture(at name: String) -> [String]{
        
        if (name == "butterflyNumbers"){
            return butterflyNumbersNeeded
        }
        else if (name == "rainbowNumbers"){
            return raindbowNumbersNeeded
        }
        else{
            return cupcakeNumbersNeeded
        }
    }
    
    //get the title of the pictures
    func picturePrefix () -> String{
        return prefix
    }
    
    func checkerPrefix() -> String{
        return "CheckerImage"
    }
    
    func colorAtI(at ind: String) -> Int{
        return orderOfColors.firstIndex(of: ind)!
    }
    
    func colorNameAtTag(at Ind: Int) -> String{
        return orderOfColors[Ind-1]
    }
    
    func numberOfColors() -> Int{
        return orderOfColors.count
    }
    
    func colorByNumberNameArray() -> [String]{
        return colorByNumberPictures
    }
    
    func imageAtColorTag(at ind: Int) -> String{
        return colorByNumberPictures[ind]
    }
    
    func freeColorImageAtIndex(at ind: Int) -> String{
        return freeColorPictures[ind]
    }
    
    func numberOfFreeColor() -> Int{
        return freeColorPictures.count
    }
    
    func numberOfColorNumber() -> Int{
        return colorByNumberPictures.count
    }
    
    
    
    func cupcakeIsRed(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: RedCupcake, touchPoint: touchPoint)
    }
    
    func cupcakeIsBrown(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: BrownCupcake, touchPoint: touchPoint)
    }
    
    func cupcakeIsGreen(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: GreenCupcake, touchPoint: touchPoint)
    }
    
    func cupcakeIsPink(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: PinkCupcake, touchPoint: touchPoint)
    }
    
    func rainbowIsRed(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: RedRainbow, touchPoint: touchPoint)
    }
    
    func rainbowIsGreen(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: GreenRainbow, touchPoint: touchPoint)
    }
    
    func rainbowIsOrange(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: OrangeRainbow, touchPoint: touchPoint)
    }
    
    func rainbowIsBlue(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: BlueRainbow, touchPoint: touchPoint)
    }
    
    func rainbowIsYellow(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: YellowRainbow, touchPoint: touchPoint)
    }
    
    func butterflyIsBrown(at touchPoint: CGPoint) -> Bool{
       return checkTouch(at: BrownButterfly, touchPoint: touchPoint)
    }
    
    func butterflyIsBlack(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: BlackButterfly, touchPoint: touchPoint)
    }
    
    func checkTouch(at points: LionPoints, touchPoint: CGPoint) -> Bool{
        
        let xPoint = Double(touchPoint.x)
        let yPoint = Double(touchPoint.y)
        
        for i in stride(from: -12, to: 12, by: 0.5) {
            let newPoint = CGPoint(x: xPoint+i, y: yPoint)
            
            if points.contains(newPoint){
                return true
            }
        }
        
        for i in stride(from: -12, to: 12, by: 0.5) {
            let newPoint = CGPoint(x: xPoint, y: yPoint+i)
            
            if points.contains(newPoint){
                return true
            }
        }
        
        return false
    }
    
    func butterflyIsPink(at touchPoint: CGPoint) -> Bool{
       return checkTouch(at: PinkButterfly, touchPoint: touchPoint)
    }
    
    func butterflyIsOrange(at touchPoint: CGPoint) -> Bool{
        return checkTouch(at: OrangeButterfly, touchPoint: touchPoint)
    }
}
