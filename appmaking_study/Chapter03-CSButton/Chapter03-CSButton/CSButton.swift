//
//  CSButton.swift
//  Chapter03-CSButton
//
//  Created by 엔나루 on 2021/08/20.
//

import UIKit

public enum CSButtonType {
    case rect
    case circle
}

class CSButton: UIButton {
    
    //스토리보드 방식으로 정의된 버튼이 이 버튼이다 라고 하려고 함
    //스토리보드가 연결된 클래스의 init(coder: NSCoder){} 를 부름
    //이 함수가 불려짐. NSCoder 클래스를 통해 전달되는 이유는
    //스토리보드상 정의된 버튼을 NSCoder 를 통해 전달하기 때문에
    //NSCoder 로 받아야 함.
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        //스토리보드 방식으로 버튼을 정의했을 때 적용됨.
        self.backgroundColor = .green
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitle("버튼", for: .normal)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.setTitle("코드로 생성된 버튼", for: .normal)
    }
    
    init() {
        //super.init() <= 불가능
        super.init(frame: CGRect.zero)
    }
}
