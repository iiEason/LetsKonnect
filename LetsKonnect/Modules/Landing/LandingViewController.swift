//
//  LandingViewController.swift
//  Landing
//
//  Created by L on 2022/2/10.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    var onStart: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    @IBAction func onStartTapped(_ sender: Any) {
        self.onStart?()
    }
    
}

private extension LandingViewController {
    
    func setupUI() {
        
        self.logoImageView.image = UIImage.init(named: "icon_logo", in: Bundle(for: LandingViewController.self), with: nil)
        self.startButton.setImage(UIImage.init(named: "logindenglu", in: Bundle(for: LandingViewController.self), with: nil), for: .normal)
        
    }
    
    
}
