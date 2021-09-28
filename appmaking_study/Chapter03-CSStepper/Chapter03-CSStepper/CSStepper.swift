//
//  CSStepper.swift
//  Chapter03-CSStepper
//
//  Created by 엔나루 on 2021/09/28.
//

import UIKit

public class CSStepper: UIView {
    
    public var leftBtn = UIButton(type: .system) //좌측 버튼
    public var rightBtn = UIButton(type: .system) //우측 버튼
    public var centerLabel = UILabel() //중앙 레이블
    public var value:Int = 0
    
    private func setup() {
        
        let borderwidth: CGFloat = 0.5
        let borderColor = UIColor.blue.cgColor
        
        //좌측 다운 버튼 속성 설정
        self.leftBtn.tag = -1 //태그값에 -1을 부여
        self.leftBtn.setTitle("⬇︎", for: .normal) //버튼의 타이틀
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) //버튼의 타이틀폰트
        
        self.leftBtn.layer.borderWidth = borderwidth //테두리 두께
        self.leftBtn.layer.borderColor = borderColor //테두리 색상
        
        self.rightBtn.tag = 1
        self.rightBtn.setTitle("⬆︎", for: .normal)
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.rightBtn.layer.borderWidth = borderwidth
        self.rightBtn.layer.borderColor = borderColor
        
        self.centerLabel.text = String(value)
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center
        self.centerLabel.backgroundColor = .cyan
        self.centerLabel.layer.borderWidth = borderwidth
        self.centerLabel.layer.borderColor = borderColor
        
        self.addSubview(leftBtn)
        self.addSubview(rightBtn)
        self.addSubview(centerLabel)
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        //버튼의 너비 = 뷰 높이
        let btnWidth = self.frame.height
        let lblWidth = self.frame.width - (btnWidth*2)
        
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        self.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: lblWidth, height: btnWidth)
        self.rightBtn.frame = CGRect(x: btnWidth+lblWidth, y: 0, width: btnWidth, height: btnWidth)
    }
    
    //스토리보드 호출 초기화 메소드
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    //프로그래밍 방식으로 호출할 초기화 메소드
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
}
