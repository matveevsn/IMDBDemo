//
//  ViewController.swift
//  IMDB_demo
//
//  Created by Sergey Matveev on 28.03.2023.
//

import UIKit

struct Poster: Decodable {
    var imageUrl: String?
    var height: Int?
    var width: Int?
}

struct Item: Decodable {
    var id: String?
    var l: String?
    var q: String?
    var i: Poster?
}

struct ContextResponce: Decodable {
    var d: [Item]?
    var q: String?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let headers = [
            "X-RapidAPI-Key": "2e711aa442msh5c6b133309aa2ebp11c499jsncef97c6a8af3",
            "X-RapidAPI-Host": "imdb8.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://imdb8.p.rapidapi.com/auto-complete?q=game%20of%20thr")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse ?? "")
                if let responceData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: responceData, options: []) as? [String : Any]
                        print("json: \(String(describing: json))")
                        let decoder = JSONDecoder()
                        let responce = try decoder.decode(ContextResponce.self, from: responceData)
                        print("responce \(responce)")
                    } catch {
                        print("errorMsg")
                    }
                }
            }
        })

        dataTask.resume()
    }
}
