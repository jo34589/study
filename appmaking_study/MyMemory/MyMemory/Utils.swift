//
//  Utils.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/10/18.
//

import Foundation
import UIKit

extension UIViewController {
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}
