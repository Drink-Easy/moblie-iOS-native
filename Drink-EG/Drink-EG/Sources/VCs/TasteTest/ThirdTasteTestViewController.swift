//
//  ThirdTasteTestViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 8/2/24.
//

import UIKit

class ThirdTasteTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named:"icon_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"icon_back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        view.backgroundColor = .white
    }

}
