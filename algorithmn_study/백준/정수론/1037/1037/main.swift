//
//  main.swift
//  1037
//
//  Created by 조선우 on 2021/01/12.
//

func main() {
    _ = readLine()!
    var arr = readLine()!.split(separator: " ").map() {Int($0)!}
    arr.sort()
    print(arr[0] * arr[arr.count-1])
}

main()
