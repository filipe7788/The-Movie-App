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
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func getVideo(){
        let url = Constants.baseURL+EnumURL.Video(idFilme).path+Constants.api_key+Constants.endOfURL
        Alamofire.request(url).responseArray(keyPath: "results") { (response: DataResponse<[Video]>) in
            if let videos = response.result.value{
                var urlVideo = URL(string: "http://youtube.com/embed/"+videos[0].key!)
                self.webView.loadRequest(URLRequest(url: urlVideo!))
            }
        }
    }
    
}
