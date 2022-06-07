//
//  ProfileViewController.swift
//  Profile
//
//  Created by L on 2022/2/21.
//

import UIKit
import EmptyView
import RxSwift

class ProfileViewController: UIViewController {

    private var presenter: Presentation!
    
    var presenterProducer: Presenter.Producer!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = presenterProducer((
            onLogout: self.logoutButton.rx.tap.asDriver(), ()
        ))

        self.setupUI()
        
        self.setupBinding()
    }


}

private extension ProfileViewController {
    
    func setupUI() {

        let maleImage = UIImage(named: "icon_profile_male", in: Bundle(for: type(of: self)), with: nil)!
        self.profileImageView.image = maleImage
    }
    
    func setupBinding() {
        
        presenter.output.email
            .drive(self.emailLabel.rx.text)
            .disposed(by: self.bag)
        
        presenter.output.username
            .drive(self.usernameLabel.rx.text)
            .disposed(by: self.bag)
        
    }
    
}
