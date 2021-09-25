//https://programmers.co.kr/learn/courses/30/lessons/12973
//Swift

import Foundation
//timed out
func tiemd_out_solution(_ s:String) -> Int{
    
    var str = s.map {String($0)}
    var flag = true
    var toremove:[Int] = []
    while !str.isEmpty && flag {
        
        for i in toremove.reversed() {
            str.remove(at: i)
            str.remove(at: i)
        }
        toremove = []
        if str.isEmpty {
            break
        }
        var contflag = false
        for i in 0 ..< str.count-1 {
            if contflag == true {
                contflag = false
                continue
            }
            if str[i] == str[i+1] {
                toremove.append(i)
                contflag = true
            }
        }
        
        if toremove.isEmpty {
            flag = false
        }
        //print(str)
    }
    
    if str.isEmpty {
        return 1
    } else {
        return 0
    }
}

func solution(_ s:String) -> Int {
    
    var stack: [String] = []
    let str = s.map {String($0)}
    
    for char in str {
        if stack.isEmpty {
            stack.append(char)
        } else {
            if stack.last! != char {
                stack.append(char)
            } else {
                stack.removeLast()
            }
        }
        print(stack)
    }
    
    if stack.isEmpty {
        return 1
    } else {
        return 0
    }
}

solution("baabaa")

