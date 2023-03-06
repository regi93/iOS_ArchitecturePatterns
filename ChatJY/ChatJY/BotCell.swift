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
    private func configureCell(){
        self.botChatTextView.backgroundColor = .blue
        self.botChatTextView.sizeToFit()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
