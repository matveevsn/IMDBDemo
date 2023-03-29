//
//  IMDBService.swift
//  IMDB_demo
//
//  Created by Sergey Matveev on 29.03.2023.
//

import Foundation

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

class IMDBService {

    static let shared: IMDBService = IMDBService()

    private let headers = [
        "X-RapidAPI-Key": "2e711aa442msh5c6b133309aa2ebp11c499jsncef97c6a8af3",
        "X-RapidAPI-Host": "imdb8.p.rapidapi.com"
    ]

    private init() {
    }

    func loadIMDBItems(context: String, completion: @escaping (ContextResponce?, Bool) -> Void) {
        guard let url = URL(string: "https://imdb8.p.rapidapi.com/auto-complete?q=\(context)") else { completion(nil, false); return }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            var contextResponce: ContextResponce?
            if error == nil && (response as? HTTPURLResponse)?.statusCode == 200 {
                if let responceData = data {
                    do {
                        contextResponce = try JSONDecoder().decode(ContextResponce.self, from: responceData)
                    } catch {
                        print("errorMsg")
                    }
                }
            }
            completion(contextResponce, error == nil)
        })
        dataTask.resume()
    }
}
