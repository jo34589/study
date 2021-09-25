import Foundation

func solution(_ s:String) -> [Int] {
    
    var str = s
    str.removeLast(2)
    var strarr = str.components(separatedBy: CharacterSet(charactersIn: "}{"))
    strarr.removeAll(where: {$0 == "" || $0 == ","})
    var intarr:[[Int]] = []
    for e in strarr {
        intarr.append(e.split(separator: ",").map({Int($0)!}))
    }
    intarr.sort(by: {$0.count < $1.count})
    
    var ans:[Int] = []
    ans.append(contentsOf: intarr[0])
    var anssum = ans[0]
    for i in 1 ..< intarr.count {
        let intarrsum = intarr[i].reduce(0, +)
        ans.append(intarrsum - anssum)
        anssum = intarrsum
    }
    return ans
}

solution("{{4,2,3},{3},{2,3,4,1},{2,3}}")
