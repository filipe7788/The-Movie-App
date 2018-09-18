//
//  VideoViewController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 10/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

class VideoViewController: UIViewController {

    var idFilme = Int()
    var model = FilmesViewModel()
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo()
    }
    
    func getVideo(){
        model.getVideo(idFilme: idFilme, completion: { url in
            self.webView.loadRequest(URLRequest(url: url!))
       })
    }
    
}
