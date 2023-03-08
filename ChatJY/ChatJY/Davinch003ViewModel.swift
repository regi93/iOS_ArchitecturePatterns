//
//  Davinch003ViewModel.swift
//  ChatJY
//
//  Created by 유준용 on 2023/03/02.
//

import Foundation
import Alamofire

enum finishReason: String{
    case length
    case stop
}

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
    private let apiKey = "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"
//    ProcessInfo.processInfo.environment["API_KEY"]

    func generateText(prompt: String, completion: @escaping (String?, Error?) -> ()) {
        let url = URL(string: "\(baseURL)/completions")!
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
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
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("🐙value: \(value)")
                    
                    if let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted){
                        let parsedData = parseOpenAIResponse(data)
                        if let  choice = parsedData?.choices.first{
                            
                            print(choice?.text ?? "파싱에러")
                            completion("🐙아직안끝남🐙" + (choice?.text ?? "파싱에러"), nil)

                            if choice?.finishReason == finishReason.length.rawValue { // 아직 bot의 말이 끝나지 않은경우.
                                
                            }else{
                                completion(choice?.text ?? "파싱에러", nil)
                            }
                        }
                        
                    }
                case .failure(let error):
                    completion(nil ,error)
                }
            }
            
    }
}
//extension Request {
//    @discardableResult
//    public func log() -> Self {
//#if DEBUG
//        let queue = DispatchQueue(label: "requestLogger")
//        return self
//            .validate(statusCode: 200..<300)
//            .response(queue: queue, completionHandler: { response in
//                let url = response.request?.url?.absoluteString ?? "-"
//                let method = response.request?.httpMethod ?? "-"
//                let statusCode = response.response?.statusCode ?? -1
//                let responseBody = response.data != nil ? String(data: response.data!, encoding: .utf8) ?? "-" : "-"
//                let requestHeaders = response.request?.allHTTPHeaderFields ?? [:]
//                let responseHeaders = response.response?.allHeaderFields.map { "($0): ($1)" } ?? []
//                let result = response.result.debugDescription
//                let logMessage = "(method) '(url)': (statusCode)\n" +
//                "Request headers: (requestHeaders)\n" +
//                "Response headers: (responseHeaders)\n" +
//                "Response body: (responseBody)\n" +
//                "Result: (result)"
//                print(logMessage)
//            })
//#else
//        return self
//#endif
//    }
//}
//extension Request {
//    @discardableResult
//    public func log() -> Self {
//        #if DEBUG
//        let queue = DispatchQueue(label: "requestLogger")
//        return self
//            .validate(statusCode: 200..<300, response: response!)
//            .response(queue: queue, completionHandler: { (response,error) in
//                let url = response.request?.url?.absoluteString ?? "-"
//                let method = response.request?.httpMethod ?? "-"
//                let statusCode = response.response?.statusCode ?? -1
//                let responseBody = response.data != nil ? String(data: response.data!, encoding: .utf8) ?? "-" : "-"
//                let requestHeaders = response.request?.allHTTPHeaderFields ?? [:]
//                let responseHeaders = response.response?.allHeaderFields.map { "\($0): \($1)" } ?? []
//                let logMessage = "\(method) '\(url)': \(statusCode)\n" +
//                    "Request headers: \(requestHeaders)\n" +
//                    "Response headers: \(responseHeaders)\n" +
//                    "Response body: \(responseBody)"
//                print(logMessage)
//            })
//        #else
//        return self
//        #endif
//    }
//}
//curl https://api.openai.com/v1/completions \
//  -H "Content-Type: application/json" \
//  -H "Authorization: Bearer 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" \
//  -d '{
//  "model": "text-davinci-003",
//  "prompt": "Human: 안녕 내이름은 유준용이야 Human: 내 이름이 뭐게? ",
//  "temperature": 0.9,
//  "max_tokens": 300,
//  "top_p": 1,
//  "frequency_penalty": 0.0,
//  "presence_penalty": 0.6,
//  "stop": [" Human:", " AI:"]
//}'
