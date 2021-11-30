//
//  ViewController.swift
//  Chapter08-APITest
//
//  Created by 엔나루 on 2021/11/15.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
//info.plist 에서 App Transport Security Settings 를 수정했음.
//HTTPS 만 허용하는걸 피하기 위함.
    
    //MARK: - GET 호출
    @IBOutlet weak var currentTime: UILabel!
    
    @IBAction func callCurrentTime(_ sender: Any) {
        do {
            //url설정 및 GET 방식으로 api 호출
            let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime")
            //아니 이것만으로 된다고?
            let response = try String(contentsOf: url!)
            
            //읽어온 값을 레이블에 표시
            self.currentTime.text = response
            self.currentTime.sizeToFit()
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    
    // MARK: - POST(echo)
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var responseView: UITextView!
    
    @IBAction func post(_ sender: Any) {
        //1. 전송할 값을 준비한다.
        let userId = (self.userId.text)!
        let name = (self.name.text)!
        let param = "userId=\(userId)&name=\(name)"
        //key1=value1&key2=value2&key3=value3...
        
        //data객체로 변환하면 자연스럽게 url인코딩이 됨.
        let paramData = param.data(using: .utf8)
        
        //2. url 객체 정의
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echo")
        
        //3. URLRequest 객체를 정의하고 요청 내용을 담는다.
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        //4. HTTP 메시지 헤더 설정
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        //5. URLSession 객체를 통해 전송 및 응답값 처리 로직 작성
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            //5-1. 서버가 응답이 없거나 통신이 실패했을 때
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            //5-2. 응답 처리 로직
            //DispatchQueue.main.async() 는 해당 블록의 코드가 메인 스레드에서 비동기적으로 실행되도록 요청하는 역할.
            //URLSession 객체를 통해 실행되는 구문은 멀티 스레드 환경에서 메인 스레드가 아닌 서브 스레드에서 실행된다.
            //하지만 이 경우 responseView의 내용을 바꾸는(UI에 대한 처리)를 담고 있어
            //메인 스레드에서 실행되어야 한다. 따라서 메인에서 실행되도록 한 것.
            //5-2-1. 메인 스레드에서 비동기로 처리되도록 한다.
            DispatchQueue.main.async() {
                do {
                    //클로저 구문의
                    //data 변수에담긴 내용을 JSONObject 로 변환 시도
                    let object =  try JSONSerialization.jsonObject(with: data!, options: [] ) as? NSDictionary
                    //object should not be nil
                    guard let jsonObject = object else { return }
                    
                    //5-2-2. 결과값 추출
                    let result = jsonObject["result"] as? String
                    let timestamp = jsonObject["timestamp"] as? String
                    let userId = jsonObject["userId"] as? String
                    let name = jsonObject["name"] as? String
                    
                    //5-2-3. 결과가 성공일 때만 텍스트 뷰에 출력
                    if result == "SUCCESS" {
                        self.responseView.text = "아이디 : \(userId!)" + "\n"
                        + "이름 : \(name!)" + "\n"
                        + "응답결과 : \(result!)" + "\n"
                        + "응답시간 : \(timestamp!)" + "\n"
                        + "요청방식 : x-www-form-urlencoded"
                    }
                } catch let e as NSError {
                    print("An error has occured while parsing JSONObject : \(e.localizedDescription)")
                }
            } // end if DispatchQueue.main.async()
        }
        //post 전송
        task.resume()
    }
    
    // MARK: - POST(echoJSON)
    
    @IBAction func json(_ sender: Any) {
        let userId = (self.userId.text)!
        let name = (self.name.text)!
        //JSON 객체로 변환할 딕셔너리
        let param = ["userId" : userId, "name" : name]
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        //url 객체 정의
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/parctice/echoJSON")
        
        //URLRequest 객체 정의 및 요청 내용 담기
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        //http 메시지에 포함될 헤더 설정
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        
        //URLSession 객체를 통해 전송 및 응답값 처리 로직 작성
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            //5-1. 서버가 응답이 없거나 통신이 실패했을 때
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            //5-2. 응답 처리 로직
            //5-2-1. 메인 스레드에서 비동기로 처리되도록 한다.
            DispatchQueue.main.async() {
                do {
                    //클로저 구문의
                    //data 변수에담긴 내용을 JSONObject 로 변환 시도
                    let object =  try JSONSerialization.jsonObject(with: data!, options: [] ) as? NSDictionary
                    //object should not be nil
                    guard let jsonObject = object else { return }
                    
                    //5-2-2. 결과값 추출
                    let result = jsonObject["result"] as? String
                    let timestamp = jsonObject["timestamp"] as? String
                    let userId = jsonObject["userId"] as? String
                    let name = jsonObject["name"] as? String
                    
                    //5-2-3. 결과가 성공일 때만 텍스트 뷰에 출력
                    if result == "SUCCESS" {
                        self.responseView.text = "아이디 : \(userId!)" + "\n"
                        + "이름 : \(name!)" + "\n"
                        + "응답결과 : \(result!)" + "\n"
                        + "응답시간 : \(timestamp!)" + "\n"
                        + "요청방식 : x-www-form-urlencoded"
                    }
                } catch let e as NSError {
                    print("An error has occured while parsing JSONObject : \(e.localizedDescription)")
                }
            } // end if DispatchQueue.main.async()
        }
        
        task.resume()
    }
    // MARK: - POST(Alamofire)
    //not connected
    @IBAction func post2(_ sender: Any) {
        let url = "http://swiftapi.rubypaper.co.kr/2029/practice/echo"
        let param: Parameters = [
            "userId" : self.userId.text!,
            "name" : self.name.text!
            
        ]
        
        let alamo = AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody)
        
        alamo.responseJSON() { response in
            print("JSON=\(try! response.result.get())")
            if let jsonObject = try! response.result.get() as? [String: Any] {
                print("userId = \(jsonObject["userId"]!)")
                print("name = \(jsonObject["name"]!)")
            }
        }
    }
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

