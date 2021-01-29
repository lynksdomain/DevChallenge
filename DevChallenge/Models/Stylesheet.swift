//
//  Stylesheet.swift
//  DevChallenge
//
//  Created by Lynk on 1/29/21.
//

import UIKit


struct ColorGuide {
    private init() {}
    static let bgWhite = UIColor.init(red: 249/255, green: 250/255, blue: 255/255, alpha: 1)
    static let dateOrange = UIColor.init(red: 238/255, green: 158/255, blue: 77/255, alpha: 1)
    static let buttonBlue = UIColor.init(red: 75/255, green: 108/255, blue: 221/255, alpha: 1)
    static let borderGray = UIColor.init(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
    static let instructionsGray = UIColor.init(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
    static let dirtBrown = UIColor.init(red: 172/255, green: 127/255, blue: 109/255, alpha: 1)
    static let brick = UIColor.init(red: 189/255, green: 140/255, blue: 132/255, alpha: 1)
    static let mustard = UIColor.init(red: 204/255, green: 161/255, blue: 110/255, alpha: 1)
    static let washedGreen = UIColor.init(red: 143/255, green: 164/255, blue: 162/255, alpha: 1)
    static let grayBlue = UIColor.init(red: 135/255, green: 156/255, blue: 179/255, alpha: 1)
    static let circleGray = UIColor.init(red: 171/255, green: 166/255, blue: 182/255, alpha: 1)
    static let colorPickerColors = [dirtBrown,brick,mustard,washedGreen,grayBlue,circleGray]
}

struct ColorPickerValues {
    private init() {}
    static let inset: CGFloat = 10
    static let minLineSpacing: CGFloat = 20
    static let minInteritemSpacing: CGFloat = 20
}
