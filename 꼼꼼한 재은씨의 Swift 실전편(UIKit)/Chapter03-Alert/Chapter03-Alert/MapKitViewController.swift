//
//  MapKitViewController.swift
//  Chapter03-Alert
//
//  Created by 엔나루 on 2021/08/19.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {
    
    override func viewDidLoad() {
        //뷰 컨트롤러에 맵킷뷰를 추가한다.
        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view = mapkitView
        self.preferredContentSize.height = 200
        
        //위치 정보를 설정. 위/경도 사용
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
        //지도에서 보여줄 넓이. 일종의 축척. 숫자가 작을수록 좁은 범위를 확대해서 보여줌.
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        //지도 영역을 정의: 보여줄 영역 정보를 만들어 냄.
        let region = MKCoordinateRegion(center: pos, span: span)
        //지도 뷰에 표시
        mapkitView.region = region
        mapkitView.regionThatFits(region)
        //위치를 핀으로 표시
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point)
    }

}
