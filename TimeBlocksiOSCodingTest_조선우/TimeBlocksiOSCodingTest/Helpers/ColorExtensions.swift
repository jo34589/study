//
//  Colors.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import Foundation
import CoreGraphics

extension CGColor {
    public static let royalPurple = CGColor(red: 120/255, green: 81/255, blue: 169/255, alpha: 1) //#7851a9
    public static let frenchBlue = CGColor(red: 0.0, green: 114/255, blue: 187/255, alpha: 1) //#0072bb
    public static let mintGreen = CGColor(red: 152/255, green: 255/255, blue: 152/255, alpha: 1) //#98ff98
    public static let newYorkPink = CGColor(red: 215/255, green: 131/255, blue: 127/255, alpha: 1) //#d7837f
    public static let clear = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0)
    public static let CustomColors: [CGColor] = [royalPurple, frenchBlue, mintGreen, newYorkPink, clear]
}
