//
//  main.swift
//  1330
//
//  Created by 조선우 on 2020/11/15.
//. https://0urtrees.tistory.com/94
//

import Foundation

//공백단위 문자열을 입력받고 [Int] 화 하기
let intArr = readLine()!.split(separator: " ").map { Int($0) }
//줄을 읽어서(강제언랩) / 이를 split을 이용해 " " 를 기준으로 쪼갰다 / split 은 항상 map 과 같이 처리
//                                                      / map은 받은 내용을 치환하는 것 closure 로 사용
let a = intArr[0]!
let b = intArr[1]!
if (a < b) {
    print("<")
} else if (a == b) {
    print("==")
} else {
    print(">")
}
