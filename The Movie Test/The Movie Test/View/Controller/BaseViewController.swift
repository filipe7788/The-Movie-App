//
//  BaseViewController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 27/02/19.
//  Copyright © 2019 Filipe Cruz. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .clear        
        return refreshControl
    }()
    var disposeBag = DisposeBag()
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        doBindings()
    }
    
    func doBindings(){ }
    
    func startActivityIndicator(){
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
    }

    func stopActivityIndicator(){
        self.activityIndicator.stopAnimating()
    }
}
