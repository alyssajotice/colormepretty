//
//  collectionButton.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 12/3/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

import UIKit

class fontButton: UIButton {

    override var intrinsicContentSize: CGSize {
        
        let size = super.intrinsicContentSize
        
        // you can change 'addedHeight' into any value you want.
        let addedHeight = titleLabel!.font.pointSize * 0.5
        
        return CGSize(width: size.width, height: size.height + addedHeight)
    }

}
