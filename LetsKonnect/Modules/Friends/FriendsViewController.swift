//
//  FriendsViewController.swift
//  Friends
//
//  Created by L on 2022/2/21.
//

import UIKit
import EmptyView

class FriendsViewController: UIViewController {
    
    private var presenter: Presentation!
    var presenterProducer: Presenter.Producer!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = presenterProducer(())

        self.setupUI()
        
        self.setupBinding()
    }


}

private extension FriendsViewController {
    
    func setupUI() {
        let emptyImage = UIImage(named: "icon_friends_empty", in: Bundle(for: type(of: self)), with: nil)!
        let emptyView = EmptyView(frame: self.view.bounds)
        emptyView.configure(image: emptyImage, title: "Uh Ho", subtitle: "Looks like there are no friends")
        self.tableView.backgroundColor = .clear
        self.tableView.backgroundView = emptyView
    }
    
    func setupBinding() {
        
    }
    
}
