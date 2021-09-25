import Foundation

func solution(_ clothes:[[String]]) -> Int {
    var ans = 1
    var type:[String] = []
    var dress:[[String]] = Array(repeating: Array(repeating:"", count:0), count: 0)
    for clothe in clothes {
        if !type.contains(clothe[1]) {
            dress.append([clothe[0]])
            type.append(clothe[1])
        } else {
            let i = type.firstIndex(of: clothe[1])!
            dress[i].append(clothe[0])
        }
    }
    
    for i in 0 ..< type.count {
        ans *= (dress[i].count + 1)
    }
    
    return ans-1
}

solution([["yellowhat", "headgear"], ["bluesunglasses", "eyewear"], ["green_turban", "headgear"]])
