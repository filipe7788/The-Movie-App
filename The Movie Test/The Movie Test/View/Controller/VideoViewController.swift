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
    }
    
    func getVideo(){
        let url = Constants.baseURL+EnumURL.Video(idFilme).path+Constants.api_key+Constants.endOfURL
        Alamofire.request(url).responseArray(keyPath: "results") { (response: DataResponse<[Video]>) in

            switch response.result {
            case .success( _):
                if let videos = response.result.value{
                    if let chaveFilme = videos[0].key{
                        let urlVideo = URL(string: "http://youtube.com/embed/"+chaveFilme)
                        print(urlVideo?.description)
                        self.webView.loadRequest(URLRequest(url: urlVideo!))
                    }else{
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            case .failure(let _):
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
