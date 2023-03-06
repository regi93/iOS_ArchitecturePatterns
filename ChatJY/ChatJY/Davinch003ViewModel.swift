//
//  Davinch003ViewModel.swift
//  ChatJY
//
//  Created by 유준용 on 2023/03/02.
//

import Foundation
import Alamofire


func parseOpenAIResponse(_ data: Data) -> OpenAIResponse? {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
        let response = try decoder.decode(OpenAIResponse.self, from: data)
        return response
    } catch {
        print("Error parsing OpenAI API response: \(error)")
        return nil
    }
}

class OpenAIViewModel {
    private let baseURL = "https://api.openai.com/v1"
    private let token = "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"
    
    func generateText(prompt: String, completion: @escaping ((String?, Error?) -> Void)) {
        let url = URL(string: "\(baseURL)/completions")!
        let parameters: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": prompt,
            "temperature": 0.9,
            "max_tokens": 300,
            "top_p": 1,
            "frequency_penalty": 0.0,
            "presence_penalty": 0.6,
            "stop": [" Human:", " AI:"]
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    if let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted), let text = parseOpenAIResponse(data)?.choices.first??.text {
                        completion(text, nil)
                    } else {
                        completion(nil, NSError(domain: "Parsing error", code: 0, userInfo: nil))
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
