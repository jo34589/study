import Foundation

//이 풀이는 왜 틀리는가?
//가장 시작하는 인덱스가 낮은 범위를 찾기는 하지만
//가장 짧은 길이의 범위를 찾지 않는다.
//결론: 다른 기법이 필요.

//윈도우 크기를 늘려가며
//쭈욱 검사.
//조건을 만족하자마자 리턴시키기.

//효율성 맛이 가 버린 편. 왜냐: 슬라이딩 윈도우 O(N^2)
func solution3(_ gems:[String]) -> [Int] {
    
    let types = Set(gems)
    let max_len = gems.count
    let n = max_len
    var win_len = types.count-1
    while win_len < max_len {
        for i in 0 ..< n - win_len {
            let start_i = i
            let buy = Set( gems[start_i ... start_i + win_len] )
            if types.count == buy.count {
                return [ start_i + 1 , start_i + win_len + 1 ]
            }
        }
        win_len += 1
    }
    
    return []
}

//투 포인터
//end 를 밀기
//조건을 만족하면 start를 밀기
//조건을 만족하지 않으면 저장하고 end 를 다시 밀기
/*
1. 조건을 만족하거나 end가 n-1일 때 까지 end 를 민다.
2. 조건을 만족하지 않을 때 까지 start를 민다.
3. 저장하고 다시 end를 민다.
 
*/
//를 start가 끝에 올 때까지 반복
//O(n)
func solution(_ gems:[String]) -> [Int] {
    
    var start = 0, end = 0
    let types = Set(gems)
    let n = gems.count
    var c:[[Int]] = []
    var gem_dict:[String:Int] = [:]
    while true {
        if start == n {
            break
        }
        if gem_dict.keys.count == types.count {
            c.append([start+1, end])
            gem_dict[gems[start]]! -= 1
            if gem_dict[gems[start]]! == 0 {
                gem_dict.removeValue(forKey: gems[start])
            }
            start += 1
            if start > end {
                end = start
            }
        }
        if end == n {
            break
        }
        if gem_dict.keys.count != types.count {
            if gem_dict[gems[end]] == nil {
                gem_dict[gems[end]] = 1
            } else {
                gem_dict[gems[end]]! += 1
            }
            end += 1
        }
    }
    while gem_dict.keys.count == types.count && start < n {
        c.append([start+1, end])
        gem_dict[gems[start]]! -= 1
        if gem_dict[gems[start]]! == 0 {
            gem_dict.removeValue(forKey: gems[start])
        }
        start += 1
    }
    
    //print(c)
    var ans = c[0]
    for i in 0 ..< c.count {
        if ans[1] - ans[0] > c[i][1] - c[i][0] {
            ans = c[i]
        }
    }
    return ans
}

solution(["DIA", "RUBY", "RUBY", "DIA", "DIA", "EMERALD", "SAPPHIRE", "DIA"]) //[3, 7]
solution(["AA", "AB", "AC", "AA", "AC"]) //[1, 3]
solution(["XYZ", "XYZ", "XYZ"]) //[1, 1]
solution(["ZZZ", "YYY", "NNNN", "YYY", "BBB"]) //[1, 5]
solution(["DIA", "EM", "EM", "RUB", "DIA"]) //[3, 5]
