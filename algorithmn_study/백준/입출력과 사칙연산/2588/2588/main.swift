//
//  main.swift
//  2588
//
//  Created by 조선우 on 2020/11/15.
//

import Foundation

let a = Int(readLine()!)!
let b = Int(readLine()!)!

print("\(a*(b%10))")
print("\(a*((b%100)/10))")
print("\(a*(b/100))")
print("\(a*b)")

//solved
