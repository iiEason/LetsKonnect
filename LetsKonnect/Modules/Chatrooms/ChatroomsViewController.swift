//
//  ChatroomsViewController.swift
//  Chatrooms
//
//  Created by L on 2022/2/21.
//

import UIKit
import EmptyView
import RxDataSources
import RxSwift
import RxCocoa

class ChatroomsViewController: UIViewController {
    
    private var presenter: Presentation!
    var presenterProducer: Presenter.Producer!
    
    private let bag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var creatChatroomButton: UIButton = {
        let button = UIButton(type: .custom) as UIButton
        let yPosition = self.view.frame.height - 180
        let xPosition = self.view.frame.width - 100
        let creatImage = UIImage(named: "icon_chatroom_creat", in: Bundle(for: type(of: self)), with: nil)
        button.setImage(creatImage, for: .normal)
        button.frame = CGRect(x: xPosition, y: yPosition, width: 60, height: 60)
        button.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        button.layer.zPosition = 1
        return button
    }()
    
    private lazy var emptyView: EmptyView = {
        let emptyImage = UIImage(named: "icon_chatrooms_empty", in: Bundle(for: type(of: self)), with: nil)!
        let emptyView = EmptyView(frame: self.view.bounds)
        emptyView.configure(image: emptyImage, title: "Uh Ho", subtitle: "Looks like there are no chatrooms")
        return emptyView
    }()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ChatroomSection> { (_, tableView, indexPath, item) in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatroomCell.self), for: indexPath) as? ChatroomCell else { return UITableViewCell() }
        cell.configure(usingViewModel: item)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = presenterProducer(())

        self.setupUI()
        
        self.setupBinding()
        
    }
    

}

private extension ChatroomsViewController {
    
    func setupUI() {
        
        self.tableView.backgroundColor = .clear
        self.tableView.backgroundView = emptyView
        
        self.view.addSubview(self.creatChatroomButton)
        
        let chatroomCellNib = UINib(nibName: "ChatroomCell", bundle: Bundle(for: ChatroomCell.self))
        tableView.register(chatroomCellNib, forCellReuseIdentifier: String(describing: ChatroomCell.self))
    }
    
    func setupBinding() {
        
        self.presenter.output.section
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.bag)
        
        self.presenter.output.section
            .map({ $0.first! })
            .map({ $0.items.count > 0 })
            .map({ [tableView, emptyView] in tableView?.backgroundView = $0 ? nil : emptyView })
            .drive()
            .disposed(by: self.bag)
        
    }
    
}
