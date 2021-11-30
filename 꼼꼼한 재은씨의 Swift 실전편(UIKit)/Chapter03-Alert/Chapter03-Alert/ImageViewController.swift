//
//  ImageViewController.swift
//  Chapter03-Alert
//
//  Created by 엔나루 on 2021/08/19.
//

import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let icon = UIImage(named: "rating5")
        let iconV = UIImageView(image: icon)
        
        iconV.frame = CGRect(x: 0, y: 0, width: (icon?.size.width)!, height: (icon?.size.height)!)
        
        self.view.addSubview(iconV)
        
        //preferredContentSize: 외부 객체가 이 imageViewController 를 나타낼 때 참고할 사이즈를 지정
        self.preferredContentSize = CGSize(width: (icon?.size.width)!, height: (icon?.size.height)!+20)
        
        // Do any additional setup after loading the view.
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
