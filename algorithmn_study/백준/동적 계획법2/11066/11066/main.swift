//
//  main.swift
//  11066
//
//  Created by 조선우 on 2021/02/09.
//

let t = Int(readLine()!)!

for _ in 0 ..< t {
    let k = Int(readLine()!)!
    var arr = readLine()!.split(separator: " ").map() {Int($0)!}
    arr.append(0)
    arr.sort()
    print(arr)
    var dp = Array(repeating: 0, count: k+1)
    dp[1] = arr[1]
    print(dp[1], separator: "", terminator: " ")
    dp[2] = arr[1] + arr[2]
    print(dp[2], separator: "", terminator: " ")
    for i in 3 ... k {
        dp[i] = min((dp[i-1]*2) + arr[i], dp[i-2]*2 + (arr[i]+arr[i-1])*2)
        print(dp[i], separator: "", terminator: " ")
    }
    print("")
}


/*
 1개 : 자기 자체로 최소
 2개 : 선택지 없이 2개를 더하여 최소
 3개 : 2개 + 1개 <= 어떻게 선택?
    2 5 9 예시
    (2 + 9) = 11
    11, 5 = 16
    이미 발생한 코스트 11 + 16 = 27
    2 + 5 = 7
    7 + 9 = 16
    7 + 16 = 23
    
    2 5 6
    7 6 // 7
        // 13 = 20
    2 5 6
    8   5 / 8
            13
            21
    2 11 / 11
            13
            24
   2 element: cost + cost
    3 element: (1cost + 2cost) * 2 + 3cost
    4 element: ((a+b)*2 + c)* 2 + d or (a+b) * 2 + (c + d) * 2
*/
