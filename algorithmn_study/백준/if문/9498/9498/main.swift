//
//  main.swift
//  9498
//
//  Created by 조선우 on 2020/11/17.
//

import Foundation

let year: Int = Int(readLine()!)!

var isLeapYear: Int = 0

if ((year % 4 ) == 0) {
    isLeapYear = 1
    if (year % 100 == 0) {
        isLeapYear = 0
        if(year % 400 == 0) {
            isLeapYear = 1
        }
    }
}

print(isLeapYear)
