//
//  ViewController.swift
//  Soma
//
//  Created by Filipe Cruz on 15/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RESULTADO: UILabel!
    @IBOutlet weak var TEXTO2: UITextField!
    @IBOutlet weak var TEXTO1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func CALCULA(_ sender: UIButton) {
        var num1:Int  = Int(TEXTO1.text!)!
        var num2:Int  = Int(TEXTO2.text!)!
        let result = num1 + num2
        RESULTADO.text = result.description
    }
    
}

