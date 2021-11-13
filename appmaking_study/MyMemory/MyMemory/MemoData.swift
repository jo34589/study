//
//  MemoData.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/07/26.
//

import UIKit
import CoreData

class MemoData {
    var memoIdx: Int?
    var title: String?
    var contents: String?
    var image: UIImage?
    var regdate: Date?
    
    //추가: 원본 MemoMO 객체를 참조하기 위한 속성
    var objectID: NSManagedObjectID?
}
