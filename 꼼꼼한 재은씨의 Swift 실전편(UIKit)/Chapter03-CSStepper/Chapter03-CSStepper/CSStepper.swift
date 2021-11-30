//
//  CSStepper.swift
//  Chapter03-CSStepper
//
//  Created by 엔나루 on 2021/09/28.
//

import UIKit

@IBDesignable //이 클래스를 스토리보드에서 미리보기 형태로 처리해 달라고 시스템에 요청함.
public class CSStepper: /*UIView*/ UIControl {
    
    public var leftBtn = UIButton(type: .system) //좌측 버튼
    public var rightBtn = UIButton(type: .system) //우측 버튼
    public var centerLabel = UILabel() //중앙 레이블
    @IBInspectable //인터페이스 빌더의 인스펙터에서 수정가능하게 만들어줌.
    public var value:Int = 0 {
        didSet {
            self.centerLabel.text = String(value)
            //이 클래스를 사용하는 객체들에게 valueChanged 이벤트 신호를 보내준다.
            self.sendActions(for: .valueChanged)
        }
    }
    @IBInspectable
    public var leftTitle:String = "⬇︎" {
        didSet {
            self.leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    @IBInspectable
    public var rightTitle:String = "⬆︎" {
        didSet {
            self.rightBtn.setTitle(leftTitle, for: .normal)
        }
    }
    @IBInspectable
    public var bgColor: UIColor = UIColor.cyan {
        didSet {
            self.centerLabel.backgroundColor = bgColor
        }
    }
    @IBInspectable
    public var stepValue: Int = 1
    @IBInspectable
    public var maximumValue: Int = 100
    @IBInspectable
    public var minimumValue: Int = -100
    
    private func setup() {
        
        let borderwidth: CGFloat = 0.5
        let borderColor = UIColor.blue.cgColor
        
        //좌측 다운 버튼 속성 설정
        self.leftBtn.tag = -1 //태그값에 -1을 부여
        //self.leftBtn.setTitle("⬇︎", for: .normal) //버튼의 타이틀
        self.leftBtn.setTitle(self.leftTitle, for: .normal)
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) //버튼의 타이틀폰트
        self.leftBtn.layer.borderWidth = borderwidth //테두리 두께
        self.leftBtn.layer.borderColor = borderColor //테두리 색상
        
        self.rightBtn.tag = 1
        //self.rightBtn.setTitle("⬆︎", for: .normal)
        self.rightBtn.setTitle(self.rightTitle, for: .normal)
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.rightBtn.layer.borderWidth = borderwidth
        self.rightBtn.layer.borderColor = borderColor
        
        self.centerLabel.text = String(value)
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center
        //self.centerLabel.backgroundColor = .cyan
        self.centerLabel.backgroundColor = self.bgColor
        self.centerLabel.layer.borderWidth = borderwidth
        self.centerLabel.layer.borderColor = borderColor
        
        self.addSubview(leftBtn)
        self.addSubview(rightBtn)
        self.addSubview(centerLabel)
        
        self.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
    }
    
    @objc func valueChange(_ sender: UIButton) {
        
        //스테퍼의 값을 변경하기 전에 미리 최소값과 최대값 범위를 벗어나지 않는지 체크한다.
        let sum = self.value + (sender.tag * self.stepValue)
        
        if sum > self.maximumValue {
            return
        }
        if sum < self.,minimumValue {
            return
        }
        
        self.value += (sender.tag * self.stepValue)
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
