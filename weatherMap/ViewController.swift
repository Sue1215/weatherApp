//
//  ViewController.swift
//  weatherMap
//
//  Created by 内田 大輔 on 2019/03/14.
//  Copyright © 2019 内田 大輔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var label:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UITextView()
        label.text = "ロード中"
        label.frame = CGRect(x: 10, y: 30, width: self.view.frame.width - 20,height: 300)
        self.view.addSubview(label)
        
        let city = "Tokyo"
        let appId = "8bc00a061183e168000979b50b8c1b07"
        
        let urlString = "http://api.openweathermap.org/data/2.5/weather?units=metric&appid=\(appId)&q=\(city)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                DispatchQueue.main.async {
                    self.label.text = object!.description
                    self.label.sizeToFit()
                }
            } catch let e {
                print(e)
            }
        }
        task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

