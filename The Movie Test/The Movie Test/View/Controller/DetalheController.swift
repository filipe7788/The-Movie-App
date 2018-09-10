//
//  DetalheController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 10/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class DetalheController: UIViewController {

    var idFilme: Int = 0
    
    @IBOutlet weak var bannerFilme: UIImageView!
    
    @IBOutlet weak var Titulo: UIView!
    @IBOutlet weak var Descricao: UILabel!
    @IBOutlet weak var DataLancamento: UILabel!
    @IBOutlet weak var Media: UILabel!
    @IBOutlet weak var Status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilme()
    }

    @IBAction func verTrailer(_ sender: UIButton) {
    }
    
    func getFilme(){
        let url = Constants.baseURL+EnumURL.Filme(self.idFilme).path+Constants.api_key+Constants.endOfURL
        Alamofire.request(url).responseObject{ (response: DataResponse<ResMovie>) in
            switch response.result {
            case .success( _):
                if let movie = response.result.value{
                    self.refreshData(Filme: movie)
                }
            case .failure(let value):
                print(value)
            }
        }
    }
    
    func refreshData(Filme:ResMovie){
        let foto =  Data(base64Encoded: Filme.Banner ?? "", options: NSData.Base64DecodingOptions())
        bannerFilme?.image = UIImage(data: foto as! Data)
        Descricao.text = Filme.Descricao
        DataLancamento.text = Filme.DataLancamento
        Media.text = Filme.MediaNota?.description
        Status.text = Filme.Status
    }
}
