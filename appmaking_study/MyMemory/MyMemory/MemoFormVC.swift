//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/07/22.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var subject: String!
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: Any) {
        //내용을 입력하지 않았을 경우 경고창을 띄움.
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //MemoData 객체를 생성하고 데이터 입력
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        //앱 델리게이트 객체를 읽어온 다음, memolist 배열에 data를 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.append(data)
        
        //작성폼 화면을 종료하고 이전 화면으로 되돌아간다.
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: Any) {
        //사진을 고르는 버튼을 누를 때 마다
        //새 이미지 피커 인스턴스를 생성하고
        let picker = UIImagePickerController()
        //새로 생성된 인스턴스의 딜리게이트를 MemoFormVC(self) 로 지정
        picker.delegate = self
        picker.allowsEditing = true
        
        //이미지 피커 화면을 표시한다.
        self.present(picker, animated: false)
        
    }
    
    //사용자가 이미지를 선택하면 자동으로 호출될 메소드.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        //선택된 이미지를 미리보기에 출력한다.
        self.preview.image = info[.editedImage] as? UIImage
        picker.dismiss(animated: false)
    }
    
    //사용자가 텍스트 뷰에 뭔가를 입력하면 자동으로 호출될 메소드.
    func textViewDidChange(_ textView: UITextView) {
        //근데 이렇게 하면 텍스트 뷰에 뭔가 입력될 때 마다 변수를 새로 만들지 않나?
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        //타이틀에 표시
        self.navigationItem.title = self.subject
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
