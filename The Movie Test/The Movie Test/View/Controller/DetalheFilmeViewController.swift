//
//  DetalheFilmeViewController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 04/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit

class DetalheFilmeViewController: UIViewController {

    var Filme: Movie = Movie()
    var trailer: [Video] = []
    var baseRest = BaseRest()
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var nota: UILabel!
    @IBOutlet weak var dataLancamento: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let url = URL(string: "https://image.tmdb.org/t/p/w500/"+(Filme.Poster ?? ""))
        let data = try? Data(contentsOf: url!)
        poster.image = UIImage(data: data!)
       
        nota.text = Filme.MediaNota?.description
        titulo.text = Filme.Nome
        descricao.text = Filme.Descricao
        dataLancamento.text = Filme.DataLancamento
    
 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width:self.view.bounds.width, height: self.view.bounds.height)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let video = segue.destination as? VideoViewController{
            video.trailer = self.trailer
        }
    }
}
