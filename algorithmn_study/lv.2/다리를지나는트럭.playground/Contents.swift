import Foundation

func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    
    var time = 0
    var weight_on_bridge = 0
    var on_bridge = [[Int]]()
    var truck = truck_weights
    truck.reverse()
    var fin_truck_count = 0
    
    while fin_truck_count < truck_weights.count {
        time += 1
        //올라와있는 모든 차들 +1 초
        if !on_bridge.isEmpty {
            for i in 0 ..< on_bridge.count {
                on_bridge[i][1] += 1
            }
            
            //끝까지 도착한 차 하차
            if on_bridge[0][1] == bridge_length {
                weight_on_bridge -= on_bridge[0][0]
                on_bridge.removeFirst()
                fin_truck_count += 1
            }
        }
        
        //올라올 수 있으면 새로운 차 승차
        if !truck.isEmpty && truck.last! + weight_on_bridge <= weight {
            on_bridge.append([truck.removeLast(), 0])
            weight_on_bridge += on_bridge.last![0]
        }
        print(on_bridge)
    }
    
    return time
}

solution(5, 5, [1,1,1,1,1,2,2,2,2])
