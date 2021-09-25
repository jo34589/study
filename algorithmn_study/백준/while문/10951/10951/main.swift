//
//  main.swift
//  10951
//
//  Created by 조선우 on 2020/11/17.
//

import Foundation

while let line = readLine() {
    //EOF 까지 계속 입력을 받는 아주 멋진 방법.
    let arr = line.split(separator: " ").map { Int($0)! }
    print("\(arr[0] + arr[1])")
}
