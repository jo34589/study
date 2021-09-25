import Foundation

func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    
    let base_time = fees[0]
    let base_fee = fees[1]
    let over_time = fees[2]
    let over_fee = fees[3]
    
    //last time = 23:59 = 1439
    func convert_to_min(_ time: String) -> Int {
        let arr = time.map({String($0)})
        return Int(arr[0...1].joined())!*60 + Int(arr[3...4].joined())!
    }
    //record : "05:34 5961 IN"
    let rec_arr = records.map({$0.split(separator: " ").map({String($0)})})
    //print(rec_arr)
    
    var plate_time: [String : Int] = [:]
    var plate_minsum: [String : Int] = [:]
    rec_arr.forEach({
        let min = convert_to_min($0[0])
        if plate_time[$0[1]] == nil && $0[2] == "IN" {
            plate_time[$0[1]] = min
        } else {
            if $0[2] == "OUT" {
                let ext = min - plate_time[$0[1]]!
                if plate_minsum[$0[1]] == nil {
                    plate_minsum[$0[1]] = ext
                } else {
                    plate_minsum[$0[1]]! += ext
                }
                plate_time.removeValue(forKey: $0[1])
            }
        }
    })
    for (key, value) in plate_time {
        let ext = 1439 - value
        if plate_minsum[key] == nil {
            plate_minsum[key] = ext
        } else {
            plate_minsum[key]! += ext
        }
        plate_time.removeValue(forKey: key)
    }
    //print(plate_time)
    //print(plate_minsum)
    
    var plate_fee: [String:Int] = [:]
    for (key, value) in plate_minsum {
        if value <= base_time {
            plate_fee[key] = base_fee
        } else {
            let left = value - base_time
            var fee = base_fee
            if left%over_time == 0 {
                fee += (left/over_time)*over_fee
            } else {
                fee += (left/over_time + 1)*over_fee
            }
        }
    }
    let key_arr = plate_fee.keys.sorted(by: <)
    var rtn:[Int] = []
    key_arr.forEach({
        rtn.append(plate_fee[$0]!)
    })
    return rtn
}
