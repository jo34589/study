//https://programmers.co.kr/learn/courses/30/lessons/82612

import Foundation

func solution(_ price:Int, _ money:Int, _ count:Int) -> Int64{
    
    let m = Int64(money)
    let cost = Int64(price*count*(count+1)/2)
    if m < cost {
        return cost - m
    } else {
        return 0
    }
    
}
