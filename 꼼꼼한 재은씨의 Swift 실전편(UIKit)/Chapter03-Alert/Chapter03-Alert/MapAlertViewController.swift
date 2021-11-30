//
//  MapAlertViewController.swift
//  Chapter03-Alert
//
//  Created by 엔나루 on 2021/08/19.
//

import UIKit
import MapKit

class MapAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let alertBtn = UIButton(type: .system)
        
        alertBtn.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        alertBtn.center.x = self.view.frame.width/2
        alertBtn.setTitle("Map Alert", for: .normal)
        alertBtn.addTarget(self, action: #selector(mapAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(alertBtn)
        
        let imageBtn = UIButton(type: .system)
        
        imageBtn.frame = CGRect(x: 0, y: 200, width: 120, height: 30)
        imageBtn.center.x = self.view.frame.width/2
        imageBtn.setTitle("image Alert", for: .normal)
        imageBtn.addTarget(self, action: #selector(imageAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(imageBtn)
        
        let sliderBtn = UIButton(type: .system)
        sliderBtn.frame = CGRect(x: 0, y: 250, width: 100, height: 30)
        sliderBtn.center.x = self.view.frame.width/2
        sliderBtn.setTitle("Slider Alert", for: .normal)
        sliderBtn.addTarget(self, action: #selector(sliderAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(sliderBtn)
        
        let listBtn = UIButton(type: .system)
        listBtn.frame = CGRect(x: 0, y: 300, width: 100, height: 30)
        listBtn.center.x = self.view.frame.width/2
        listBtn.setTitle("List Alert", for: .normal)
        listBtn.addTarget(self, action: #selector(listAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(listBtn)
    }
    
    @objc func mapAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "choose row", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        ///알림창에 지도를 집어넣어 보자.
        //콘텐츠 뷰 컨트롤러에 들어갈 뷰 컨트롤러를 생성함
        let contentVC = MapKitViewController()
        
        //뷰 컨트롤러를 알림창의 콘텐츠 뷰 컨트롤러 속성에 등록한다.
        alert.setValue(contentVC, forKey: "contentViewController")
        ///
        
        self.present(alert, animated: false)
    }

    
    @objc func imageAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "this is your rating", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        let contentVC = ImageViewController()
        alert.setValue(contentVC, forKey: "contentViewController")
        
        self.present(alert, animated: false)
    }
    
    @objc func sliderAlert(_ sender: UIButton) {
        let contentVC = ControlViewController()
        
        let alert = UIAlertController(title: nil, message: "rate this script", preferredStyle: .alert)
        alert.setValue(contentVC, forKey: "contentViewController")
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (_) in print(">>> slider Value = \(contentVC.sliderValue)")
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: false, completion: nil)
    }
    
    @objc func listAlert(_ sender: UIButton) {
        let contentVC = ListViewController()
        contentVC.delegate = self
        
        let alert = UIAlertController(title: nil, message: "select row", preferredStyle: .alert)
        alert.setValue(contentVC, forKey: "contentViewController")
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        self.present(alert, animated: false, completion: nil)
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        print(">>> selected row number is \(indexPath)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
