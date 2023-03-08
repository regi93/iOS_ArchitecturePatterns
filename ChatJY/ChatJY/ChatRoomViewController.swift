//
//  ChatRoomViewController.swift
//  ChatJY
//
//  Created by 유준용 on 2023/03/06.
//

import UIKit

class ChatRoomViewController: UIViewController {
    let viewModel = OpenAIViewModel()
    var botChatHistory = [String]()
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var ChatFrameTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //testcode
        botChatHistory.append("Bot: 안녕하세요 말씀하세요.")
        self.ChatFrameTableView.reloadData()
        //testcode
    }
    
    private func configureUI(){
        self.ChatFrameTableView.estimatedRowHeight = 100
        self.textField.delegate = self
        
        ChatFrameTableView.rowHeight = UITableView.automaticDimension
        ChatFrameTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    @IBAction func textSend(_ sender: Any) {
        guard let text = textField.text else{return}
        viewModel.generateText(prompt: text) { responseText, error in
            if error != nil{
                fatalError("error")
            }
            DispatchQueue.main.async {
                
                self.botChatHistory.append(responseText!)
                self.ChatFrameTableView.reloadData()
            }
            
        }
    }



}
extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return botChatHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BotCell") as? BotCell else{return UITableViewCell()}
        cell.botChatTextView.text = botChatHistory[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
}

extension ChatRoomViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}
