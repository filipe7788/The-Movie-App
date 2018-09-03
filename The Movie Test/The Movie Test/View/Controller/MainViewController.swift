//
//  MainViewController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 31/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var Filmes:[Movie] = []
    @IBOutlet weak var tableview: UITableView!
    var baseRest = BaseRest()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        baseRest.getPopular()
        Filmes = baseRest.PopMovies
        tableview.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sceneChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            baseRest.getPopular()
            Filmes = baseRest.PopMovies
            tableview.reloadData()
        }
        else if sender.selectedSegmentIndex == 1{
            baseRest.getMostRated()
            Filmes = baseRest.TopMovies
            tableview.reloadData()
        }
        else if sender.selectedSegmentIndex == 2{
            baseRest.getNowPlaying()
            Filmes = baseRest.NowMovies
            tableview.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate{
    
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.Filmes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "celulaFIlme", for: indexPath) as! CelulaFilme
        
        let filme = Filmes[indexPath.row]
        
        cell.nome.text = filme.Nome
        
        var desc = filme.Descricao
        if var descricao = filme.Descricao{
            if(descricao.characters.count > 200){
                desc = String(descricao[descricao.startIndex..<descricao.index(descricao.startIndex, offsetBy: 200)])
            }
        }
        
        cell.descricao.text = desc ?? ""
        cell.dataLancamento.text = filme.DataLancamento
        cell.nota.text = filme.MediaNota?.description
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/"+(filme.Banner ?? ""))
        let data = try? Data(contentsOf: url!)
        cell.fotoFilme.image = UIImage(data: data!)
        
        return cell
    }
    
    
}
