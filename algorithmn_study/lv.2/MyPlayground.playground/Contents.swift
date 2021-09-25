func solution(_ files:[String]) -> [String] {
    var file:[[String]] = []
    let nums = ["0", "1", "2", "3", "4", "5", "6", "7", "8","9"]
    for name in files {
        let strarr = name.map({String($0)})
        var numstarti = 0
        var numendi = 0
        for i in 0 ..< strarr.count {
            if nums.contains(strarr[i]) {
                numstarti = i
                break
            }
        }
        for i in numstarti ..< strarr.count {
            if !nums.contains(strarr[i]) {
                numendi = i
                break
            }
        }
        if numendi > numstarti {
            file.append([strarr[0..<numstarti].joined(), strarr[numstarti ..< numendi].joined(), strarr[numendi...].joined()])
        } else {
            numendi = strarr.count
            file.append([strarr[0..<numstarti].joined(), strarr[numstarti ..< numendi].joined(), ""])
        }
    }
    //print(file)
    file.sort(by: {
        if $0[0].lowercased() != $1[0].lowercased() {
            return $0[0].lowercased() < $1[0].lowercased()
        } else if Int($0[1])! != Int($1[1])! {
            return Int($0[1])! < Int($1[1])!
        } else {
            return false
        }
    })
    let rtn = file.map({$0.joined()})
    //print(rtn)
    return rtn
}
solution(["F-16"])
