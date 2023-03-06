//
//  ViewController.swift
//  ChatJY
//
//  Created by 유준용 on 2023/03/02.
//

import UIKit
import RxSwift
import RxCocoa
import Security
import RxRelay

class ViewController: UIViewController {
    @IBOutlet weak var promptTextField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    private let viewModel = OpenAIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func getKeyChain(){


        // Keychain에 저장할 아이템 정보
        let service = "com.jy.ChatJY"
        let account = "user@example.com"
        let password = "secretpassword"

        // Keychain에 저장할 아이템 식별자
        let itemKey = "MyAppLogin"

        // Keychain Query 생성
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked,
            kSecAttrAccessGroup as String: "MyAppAccessGroup",
            kSecValueData as String: password.data(using: .utf8)!
        ]

        // Keychain에 아이템 추가
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("Keychain에 아이템이 추가되었습니다.")
            
            // Keychain에 추가된 아이템의 식별자 설정
            let updateQuery: [String: Any] = [
                kSecAttrGeneric as String: itemKey.data(using: .utf8)!
            ]
            
            let updateStatus = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
            if updateStatus == errSecSuccess {
                print("Keychain 아이템의 식별자가 설정되었습니다.")
            } else {
                print("Keychain 아이템의 식별자 설정 실패: \(updateStatus)")
            }
        } else {
            print("Keychain에 아이템 추가 실패: \(status)")
        }

    }
    
    @IBAction func generateText(_ sender: Any) {

        
        
        
//        guard let prompt = promptTextField.text else { return }
//        viewModel.generateText(prompt: prompt) { [weak self] text, error in
//            if let error = error {
//                print("Error generating text: \(error)")
//                return
//            }
//            self?.textView.text = text
//        }
    }
    
}

