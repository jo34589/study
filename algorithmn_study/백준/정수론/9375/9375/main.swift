//
//  main.swift
//  9375
//
//  Created by 조선우 on 2021/01/16.
//

let t = Int(readLine()!)!

for _ in 0 ..< t {
    var ans = 0
    var closet = [String : Int]()
    
    let c = Int(readLine()!)!
    for _ in 0 ..< c {
        let cloth = readLine()!.split(separator: " ").map{String($0)}
        if !closet.keys.contains(cloth[1]) {
            closet.updateValue(1, forKey: cloth[1])
        } else {
            closet[cloth[1]]! += 1
        }
    }
    //print(closet)
    ans = 1
    for (_, value) in closet {
        ans *= (value+1)
    }
    ans -= 1
    
    print(ans)
}
