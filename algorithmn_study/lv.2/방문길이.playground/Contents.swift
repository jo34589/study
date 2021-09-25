import Foundation

func solution(_ dirs:String) -> Int {
    var log:[([Int], [Int])] = []
    var start:[Int] = [0, 0]
    var end:[Int] = [0, 0]
    var ans = dirs.count
    for i in dirs.indices {
        let dir = dirs[i]
        var d = false
        switch dir {
        case "L":
            if start[0] > -5 {
                end[0] -= 1
            } else {
                d = true
            }
        case "U":
            if start[1] < 5 {
                end[1] += 1
            } else {
                d = true
            }
        case "R":
            if start[0] < 5 {
                end[0] += 1
            } else {
                d = true
            }
        case "D":
            if start[1] > -5 {
                end[1] -= 1
            } else {
                d = true
            }
        default:
            continue
        }
        guard d == false else {
            ans -= 1
            start = end
            continue
        }
        if log.contains(where: {$0 == (start, end) || $0 == (end, start)}) {
            ans -= 1
        }
        log.append((start, end))
        
        start = end
    }
    return ans
}

//solution("ULURRDLLU")
solution("LULLLLLLU")
