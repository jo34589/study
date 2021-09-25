//
//  main.swift
//  1966
//
//  Created by 조선우 on 2021/01/23.
//

struct PrintQueue {
    private var p_queue: [Int]
    private var start = 0
    private var end: Int
    
    init(arr: [Int], n: Int) {
        self.p_queue = arr
        self.end = n
    }
    
    mutating func process(pos: Int) -> Int {
        var position = pos
        var count = 0
        let n = end
        while count <= n {
            let current = p_queue[start]
            var p = true
            for i in start ..< end {
                if p_queue[i] > current {
                    p = false
                    if start == position {
                        p_queue.append(p_queue[start])
                        start += 1
                        position = end
                        end += 1
                        break
                    } else {
                        p_queue.append(p_queue[start])
                        start += 1
                        end += 1
                        break
                    }
                }
            }
            if p {
                count += 1
                if start == position {
                    return count
                }
                start += 1
            }
        }
        return -1
    }
}


let t = Int(readLine()!)!
for _ in 0 ..< t {
    let n_q = readLine()!.split(separator: " ").map{Int($0)!}
    let arr = readLine()!.split(separator: " ").map{Int($0)!}
    var q = PrintQueue(arr: arr, n:n_q[0])
    
    let ans = q.process(pos: n_q[1])
    print(ans)
}
