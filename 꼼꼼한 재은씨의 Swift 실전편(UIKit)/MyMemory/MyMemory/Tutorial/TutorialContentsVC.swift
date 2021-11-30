//
//  TutorialContentsVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/10/20.
//

import UIKit

class TutorialContentsVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        //이미지가 꽉 차도록
        self.bgImageView.contentMode = .scaleToFill
        
        //전달받은 타이틀 정보를 레이블 객체에 대입하고 크기를 조절한다.
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        //전달받은 이미지 정보를 이미지 뷰에 대입한다.
        self.bgImageView.image = UIImage(named: self.imageFile)
        
        
    }
}
