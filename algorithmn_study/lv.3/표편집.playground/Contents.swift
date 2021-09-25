//https://programmers.co.kr/learn/courses/30/lessons/81303
//Swift

import Foundation

func solution(_ n:Int, _ k:Int, _ cmd:[String]) -> String {
    
    var table: [(Int, Int)] = Array(repeating: (0, 0), count: n)
    var k:Int = k
    var stack:[Int] = []
    var ans:[String] = Array(repeating: "O", count: n)
    
    for i in 0 ..< n {
        table[i].0 = i-1
        table[i].1 = i+1
    }
    
    //for i in 0 ..< n {
    //    print("\(ans[i]), \(table[i])")
    //}
    //print(k)
    
    for c in cmd {
        let command = c.split(separator: " ").map({String($0)})
        if command[0] == "U" {
            let move = Int(command.last!)!
            for _ in 0 ..< move {
                k = table[k].0
            }
        } else if command[0] == "D" {
            let move = Int(command.last!)!
            for _ in 0 ..< move {
                k = table[k].1
            }
        } else if command[0] == "C" {
            stack.append(k)
            ans[k] = "X"
            let prev = table[k].0
            let next = table[k].1
            if prev >= 0 {
                table[prev].1 = next
            }
            if next < n {
                table[next].0 = prev
            }
            if next == n {
                k = prev
            } else {
                k = next
            }
        } else if command[0] == "Z" {
            let returned = stack.removeLast()
            ans[returned] = "O"
            let prev = table[returned].0
            let next = table[returned].1
            if prev >= 0 {
                table[prev].1 = returned
            }
            if next < n {
                table[next].0 = returned
            }
        } else {
            return "error"
        }
        //print(command)
        //for i in 0 ..< n {
        //    print("\(ans[i]), \(table[i])")
        //}
        //print(k)
    }
    
    return ans.joined()
}

//solution(8, 2, ["D 2","C","U 3","C","D 4","C","U 2","Z","Z","U 1","C"])
