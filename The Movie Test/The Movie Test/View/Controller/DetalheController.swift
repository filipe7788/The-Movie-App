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

    var idFilme: Int = Int()
    
    @IBOutlet weak var TituloFilme: UILabel!
    @IBOutlet weak var bannerFilme: UIImageView!
    
    @IBOutlet weak var labelTrailer: UILabel!
    @IBOutlet weak var Titulo: UIView!
    @IBOutlet weak var Descricao: UILabel!
    @IBOutlet weak var DataLancamento: UILabel!
    @IBOutlet weak var Media: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var btnVeja: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilme()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let view = segue.destination as? VideoViewController{
            view.idFilme = self.idFilme
        }
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
    
    func refreshData(Filme: ResMovie){
        self.TituloFilme.text = Filme.Nome
        let url = URL(string: "https://image.tmdb.org/t/p/w500/"+(Filme.Banner ?? ""))
        let data = try? Data(contentsOf: url!)
        bannerFilme?.image = UIImage(data: data as! Data)
        Descricao.text = Filme.Descricao
        DataLancamento.text = Filme.DataLancamento
        Media.text = Filme.MediaNota?.description
        Status.text = Filme.Status
    }
}
