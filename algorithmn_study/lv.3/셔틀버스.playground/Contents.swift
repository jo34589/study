//https://programmers.co.kr/learn/courses/30/lessons/17678
//Swift

import Foundation

//이제서야 알았다.
//큐 문제다
func solution(_ n:Int, _ t:Int, _ m:Int, _ timetable:[String]) -> String {
    
    //00:00 = 0
    //23:59 = 1439
    //09:00 = 540
    //10:10 = 610
    func convert_to_min(_ time: String) -> Int {
        let arr = time.map({String($0)})
        return Int(arr[0...1].joined())!*60 + Int(arr[3...4].joined())!
    }
    //버스가 오기 전까지 사람들은 기다려야만 한다.
    //콘은 같은 시간이라면 맨 마지막으로 줄을 선다.
    let p:Int =  timetable.count
    var anstime:Int = 0
    var mintable = Array(repeating: 0, count: p)
    for i in 0 ..< timetable.count {
        mintable[i] = convert_to_min(timetable[i])
    }
    mintable.sort()
    
    var q = Array(repeating: 0, count: p+1)
    var begin = 0
    var end = 0
    
    var last_shuttle_time = -1
    var this_shuttle_time = 540
    var waiting:[Int] = []
    for _ in 0 ..< n-1 {
        waiting = mintable.filter({ $0 > last_shuttle_time && $0 <= this_shuttle_time })
        
        for i in 0 ..< waiting.count {
            q[end] = waiting[i]
            end += 1
        }
        begin += m
        if begin >= end { begin = end }
        
        last_shuttle_time = this_shuttle_time
        this_shuttle_time += t
        
    }
    waiting = mintable.filter({ $0 > last_shuttle_time && $0 <= this_shuttle_time })
    for i in 0 ..< waiting.count {
        q[end] = waiting[i]
        end += 1
    }
    
    if end - begin < m {
        anstime = this_shuttle_time
    } else {
        anstime = q[begin ..< begin + m].last! - 1
    }
    
    print("waiting: \(waiting)")
    print("queue: \(q)")
    print("\(begin), \(end)")
    print("last: \(last_shuttle_time), this: \(this_shuttle_time)")
    print(anstime)
    
    let h = anstime/60
    let m = anstime%60
    let h_str =  h < 10 ? "0\(h)" : "\(h)"
    let m_str =  m < 10 ? "0\(m)" : "\(m)"
    
    return "\(h_str):\(m_str)"
}

/*
solution(1, 1, 5, ["08:00", "08:01", "08:02", "08:03"]) //"09:00"
solution(2, 10, 2, ["09:10", "09:09", "08:00"]) //"09:09"
solution(2,1,2,["09:00", "09:00", "09:00", "09:00"]) //"08:59"
solution(1, 1, 5, ["00:01", "00:01", "00:01", "00:01", "00:01"])//"00:00"
solution(1, 1, 1, ["23:59"])//"09:00"
solution(10, 60, 45, ["23:59","23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59"]) //"18:00"
solution(2,10,3,["09:05","09:09","09:13"]) //"09:10"
solution(1, 1, 5, ["00:01", "00:01", "00:01","00:01", "00:01", "00:02", "00:03", "00:04"])
*/

