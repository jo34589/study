import Foundation

func solution(_ expression:String) -> Int64 {
    
    var numbers:[Int64] = []
    var operations:[String] = []
    var opset:Set<String> = []
    var op_priority:[[String]] = []
    var maxn:Int64 = Int64.min
    var minn:Int64 = Int64.max
    
    let str = expression.map({String($0)})
    var start = 0
    for i in 0 ..< str.count {
        if str[i] == "+" {
            operations.append("+")
            opset.insert("+")
            numbers.append(Int64(str[start ..< i].joined())!)
            start = i+1
        } else if str[i] == "-" {
            operations.append("-")
            opset.insert("-")
            numbers.append(Int64(str[start ..< i].joined())!)
            start = i+1
        } else if str[i] == "*" {
            operations.append("*")
            opset.insert("*")
            numbers.append(Int64(str[start ..< i].joined())!)
            start = i+1
        } else {
            continue
        }
    }
    numbers.append(Int64(str[start ..< str.count].joined())!)
    
    switch opset.count {
    case 2:
        op_priority.append(Array(opset))
        op_priority.append(op_priority[0].reversed())
    case 3:
        op_priority = [["+","-","*"], ["-","+","*"], ["+","*","-"], ["-","*","+"], ["*","+","-"], ["*","-","+"]]
    default:
        //1
        op_priority = [Array(opset)]
    }

    for pri in op_priority {
        var num = numbers
        var ops = operations
        while num.count > 1 {
            for calc in pri {
                while ops.contains(calc) {
                    let i = ops.firstIndex(of: calc)!
                    if ops[i] == "+" {
                        num[i] = num[i] + num[i+1]
                        num.remove(at: i+1)
                        ops.remove(at: i)
                    } else if ops[i] == "-" {
                        num[i] = num[i] - num[i+1]
                        num.remove(at: i+1)
                        ops.remove(at: i)
                    } else {
                        num[i] = num[i] * num[i+1]
                        num.remove(at: i+1)
                        ops.remove(at: i)
                    }
                    //print(num)
                    //print(ops)
                }
            }
        }
        if num[0] >= maxn {
            maxn = num[0]
        }
        if num[0] <= minn {
            minn = num[0]
        }
    }
    
    return max(abs(maxn), abs(minn))
}

//solution("100-200*300-500+20")
solution("50*6-3*2")
