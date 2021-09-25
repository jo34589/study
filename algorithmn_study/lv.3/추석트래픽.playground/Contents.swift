import Foundation

func solution(_ lines:[String]) -> Int {
    /*
    let line = "2016-09-15 20:45:33.012"
    let lineDateFormatter = DateFormatter()
    lineDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    var lineDate = lineDateFormatter.date(from: line)!
    //밀리초 단위까지 출력시키기 위함.
    print(lineDateFormatter.string(from: lineDate))
    //2016-09-15 20:45:33.012
    
    var span1 = "2s"
    //아래 문장이 없으면 timeInterval 이 nil을 던짐
    //timeInterval 의 기본 단위는 초.
    span1.removeLast()
    let interval = TimeInterval(span1)!
    lineDate -= interval
    print(lineDateFormatter.string(from: lineDate))
    
    var span2 = "2.000s"
    span2.removeLast()
    let interval2 = TimeInterval(span2)!
    lineDate -= interval2
    print(lineDateFormatter.string(from: lineDate))
    
    var span3 = "2.002s"
    span3.removeLast()
    let interval3 = TimeInterval(span3)!
    lineDate -= interval3
    print(lineDateFormatter.string(from: lineDate))
    */
    /*
    2016-09-15 20:45:33.012
    2016-09-15 20:45:31.012
    2016-09-15 20:45:29.012
    2016-09-15 20:45:27.010
    */
    /*
     예를 들어, 로그 문자열 2016-09-15 03:10:33.020 0.011s은 "2016년 9월 15일 오전 3시 10분 33.010초"부터 "2016년 9월 15일 오전 3시 10분 33.020초"까지 "0.011초" 동안 처리된 요청을 의미한다. (처리시간은 시작시간과 끝시간을 포함)
     이 조건때문에 범위가 다소 까다로움.
     DateInterval 의 intersects 함수가 어떤 원리로 돌아가는지 잘 알 필요가 있음.
        intersects 함수는 겹치는 '범위'가있어야 true 다.
        이번 문제에선 적합하지 않음.
     */
    //https://developer.apple.com/documentation/foundation/dateinterval
    
    var dates:[DateInterval] = []
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let millisec = TimeInterval(0.001)
    let sec = TimeInterval(1)
    let n = lines.count
    var count = 0
    
    //https://softworking.tistory.com/379
        //끝값에 999ms를 추가하는 방법으로 굳이 범위를 설정하지 않아도 되게 되었다.
    for line in lines {
        let arr = line.split(separator: " ").map({String($0)})
        let linestr = arr[0...1].joined(separator: " ")
        var span = arr[2]
        span.removeLast()
        let lineDate = dateFormatter.date(from: linestr)!
        let interval = TimeInterval(span)! - millisec
        dates.append(DateInterval(start: lineDate - interval, end: lineDate + sec - millisec))
    }
    
    //can form range with Date but Date is not Stridable.
    //24시간을 밀리초로 쭉 민다면?
        //24h = 86400000 , 8640만 루프 * 2000 => 불가.
    //count 가 변하는 곳은 어디? 각 dateinterval 의 시작과 끝.
    for i in 0 ..< n {
        let startTime = dates[i].start
        let endTime = dates[i].end
        var c1 = 0, c2 = 0
        for i in 0 ..< n {
            if dates[i].contains(startTime) {
                c1 += 1
            } else if dates[i].contains(endTime) {
                c2 += 1
            }
        }
        let c = max(c1, c2)
        if count < c {
            count = c
        }
    }
    
    return count
}

//solution(["2016-09-15 01:00:04.001 2.0s", "2016-09-15 01:00:07.000 2s"])
    //4.001 => 5.000 5.001 ~ 7.0
    //이라면 겹쳐서는 안됨.
