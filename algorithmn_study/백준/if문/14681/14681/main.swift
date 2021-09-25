//
//  main.swift
//  14681
//
//  Created by 조선우 on 2020/11/17.
//

import Foundation

let x: Int = Int(readLine()!)!
let y: Int = Int(readLine()!)!

if (x > 0) {
    if(y > 0) {
        print("1")
    } else {
        print("4")
    }
} else {
    if(y > 0) {
        print("2")
    } else {
        print("3")
    }
}
