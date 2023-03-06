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
        botChatHistory.append("Bot: 안녕하세요 말씀하세요.")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func textSend(_ sender: Any) {
        viewModel.generateText(prompt: textField.text!) { str, error in
            if error == nil{
                print("Error generating text: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.botChatHistory.append(str!)
            }
        }
    }
    private func configureUI(){
        self.ChatFrameTableView.estimatedRowHeight = 100
    }

}
extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return botChatHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BotCell") as? BotCell else{return UITableViewCell()}
        cell.botChatTextView.text = botChatHistory[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension ChatRoomViewController: UITextFieldDelegate {
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.textField.resignFirstResponder()
    return true
  }
}
