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
    var model = FilmesViewModel()
    
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
        model.getFilme(idFilme: idFilme, completion: { Filme in
            self.TituloFilme.text = Filme?.Nome
            self.bannerFilme?.image = self.model.getFoto(url: Filme?.Banner ?? "")
            self.Descricao.text = Filme?.Descricao
            self.DataLancamento.text = Filme?.DataLancamento
            self.Media.text = Filme?.MediaNota?.description
            self.Status.text = Filme?.Status
        })
    }
}
