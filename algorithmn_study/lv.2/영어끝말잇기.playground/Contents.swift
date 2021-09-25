import Foundation

func solution(_ n:Int, _ words:[String]) -> [Int] {
    var ans:[Int] = [0, 0]
    var seq:[String] = []
    seq.append(words[0])
    for i in 1 ..< words.count {
        let lastchar = seq.last!.last!
        let newword = words[i]
        if lastchar != newword.first! || seq.contains(newword) {
            ans[1] = i/n + 1
            ans[0] = i%n + 1
            break
        }
        seq.append(newword)
    }
    
    return ans
}
