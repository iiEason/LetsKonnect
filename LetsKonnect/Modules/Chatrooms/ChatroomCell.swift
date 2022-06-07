//
//  ChatroomCell.swift
//  Chatrooms
//
//  Created by L on 2022/3/29.
//

import UIKit
import RxSwift

class ChatroomCell: UITableViewCell {

    @IBOutlet weak var chatroomImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var unreadCountLabel: UILabel!
    
    private var reuseBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reuseBag = DisposeBag()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(usingViewModel viewModel: ChatroomViewModel) {
        self.titleLabel.text = viewModel.title
        viewModel.statusMessage
            .asDriver()
            .drive(self.statusLabel.rx.text)
            .disposed(by: self.reuseBag)
        
        viewModel.timestamp
            .asDriver()
            .drive(self.timestampLabel.rx.text)
            .disposed(by: self.reuseBag)
    }
    
}
