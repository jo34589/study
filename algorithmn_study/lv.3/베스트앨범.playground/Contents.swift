//https://programmers.co.kr/learn/courses/30/lessons/42579
//Swift 입니다.

import Foundation

func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    
    var ans:[Int] = []
    let types = Array(Set(genres))
    var dict1:[String:(Int, Int)] = [:]
    var dict2:[Int: (String, Int)] = [:]
    types.forEach({ dict1[$0] = (0, 0) })
    for i in 0 ..< genres.count {
        dict2[i] = (genres[i], plays[i])
        for t in 0 ..< types.count {
            if genres[i] == types[t] {
                dict1[genres[i]]?.0 += plays[i]
                dict1[genres[i]]?.1 += 1
            }
        }
    }
    
    let sorteddict1 = dict1.sorted(by: { $0.value.0 > $1.value.0 })
    let sorteddict2 = dict2.sorted(by: { $0.value.1 > $1.value.1 })
    
    for type_index in 0 ..< sorteddict1.count {
        let g = sorteddict1[type_index]
        let genre = g.key
        let num_of_songs = g.value.1
        var filtered = sorteddict2.filter({ $0.value.0 == genre })
        if num_of_songs > 1 {
            ans.append(filtered.first!.key)
            filtered.removeFirst()
            ans.append(filtered.first!.key)
        } else {
            ans.append(filtered.first!.key)
        }
    }
    
    
    return ans
}

//solution(["classic", "pop", "classic", "classic", "pop"], [500, 600, 150, 800, 2500])
//solution(["classic", "pop", "classic", "classic", "classic"], [500, 1000, 400, 300, 200, 100])
// [0,2,1];
