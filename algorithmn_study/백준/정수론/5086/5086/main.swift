//
//  main.swift
//  5086
//
//  Created by 조선우 on 2021/01/12.
//

//import Foundation

func main() {
    while true {
        let input = readLine()!.split(separator: " ").map {Int($0)!}
        if input[0] == 0 && input[1] == 0 {
            break
        }
        if input[1] % input[0] == 0 && input[1] > input[0] {
            print("factor")
        } else if input[0] % input[1] == 0 && input[0] > input[1] {
            print("multiple")
        } else {
            print("neither")
        }
    }
}

main()
