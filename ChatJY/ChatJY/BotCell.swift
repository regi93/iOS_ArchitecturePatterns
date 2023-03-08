//
//  otCell.swift
//  ChatJY
//
//  Created by 유준용 on 2023/03/06.
//

import UIKit

class BotCell: UITableViewCell {

    @IBOutlet weak var botChatTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(){
        self.botChatTextView.backgroundColor = .blue
        print(self.botChatTextView.frame.height)
        print(self.botChatTextView.text)
        sizing()
        print(self.botChatTextView.frame.height)
    }
    
    private func sizing(){
        botChatTextView.isEditable = false
        botChatTextView.isScrollEnabled = false
        let fixedWidth = botChatTextView.frame.size.width
        let newSize = botChatTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        botChatTextView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
