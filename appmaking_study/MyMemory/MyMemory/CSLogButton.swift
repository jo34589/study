//
//  CSLogButton.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/09/29.
//

import UIKit

public enum CSLogType: Int {
    case basic
    case title
    case tag
}

public class CSLogButton: UIButton {
    
    public var logType: CSLogType = .basic
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //버튼에 스타일 적용
        self.setBackgroundImage(UIImage(named: "button-bg"), for: .normal)
        self.tintColor = .white
        
        //버튼의 클릭 이벤트에 logging 메소드를 연결하기
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
    }
    
    @objc func logging(_ sender: UIButton) {
        switch self.logType {
        case .basic:
            NSLog("버튼이 클릭되었습니다.")
    
        case .title:
        let btnTitle = sender.titleLabel?.text ?? "타이틀 없는"
            //?? : nil 병합 연산자: 앞쪽에 옵셔널 타입의 값, 뒤는 이를 대체할 값.
            // 옵셔널의 값이 nil 이 아니면 앞의 값, nil 이면 뒤의 값.
        NSLog("\(btnTitle) 버튼이 클릭되었습니다.")
            
        case .tag:
            NSLog("\(sender.tag) 버튼이 클릭되었습니다.")
        }
    }
}
