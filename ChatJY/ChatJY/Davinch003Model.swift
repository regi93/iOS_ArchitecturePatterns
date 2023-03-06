////
////  Davinch003Model.swift
////  ChatJY
////
////  Created by 유준용 on 2023/03/02.
////
//

import RxSwift
import Foundation
struct OpenAIResponse: Decodable {
    let id: String?
    let object: String?
    let created: Int?
    let model: String?
    let choices: [OpenAIChoice?]
    let usage: OpenAIUsage?
}

struct OpenAIChoice: Decodable {
    let text: String?
    let index: Int?
    let logprobs: OpenAILogProbs?
    let finishReason: String?
}

struct OpenAILogProbs: Decodable {
    let tokens: [String]
    let tokenLogprobs: [Double]
    let topLogprobs: [[String: Double]]
    let textOffset: [Int]
    let leftContext: [String]
    let rightContext: [String]
}

struct OpenAIUsage: Decodable {
    let promptTokens: Int?
    let completionTokens: Int?
    let totalTokens: Int?
    
    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}
