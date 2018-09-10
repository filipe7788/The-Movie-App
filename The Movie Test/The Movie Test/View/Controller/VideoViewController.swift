//
//  VideoViewController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 04/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    var trailer: [Video] = []
    @IBOutlet weak var trailerVIew: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlVideo = URL(string: ("youtube.com/embed/\(trailer[0].key)") )
        trailerVIew.loadRequest(URLRequest(url: urlVideo!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
