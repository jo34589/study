//
//  main.swift
//  2908
//
//  Created by 조선우 on 2020/12/22.
//

import Foundation

let line = readLine()!.split(separator: " ").map { Int(String(String($0).reversed()))! }
//print(line)
if line[0] > line[1] {
    print(line[0])
} else {
    print(line[1])
}
