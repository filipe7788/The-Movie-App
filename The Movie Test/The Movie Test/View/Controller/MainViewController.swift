//
//  MainViewController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 31/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class MainViewController: UIViewController {
    
    let baseURL = "https://api.themoviedb.org/3/"
    let api_key = "api_key=2bae12ea6f75b14280cce8dc6ea5f242"
    let endOfURL = "&language=pt-BR"
    
    var Filmes:[Movie] = []
    @IBOutlet weak var tableview: UITableView!
    var baseRest = BaseRest()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        baseRest.getPopular()
        getFilmes(url: EnumURL.Populares)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sceneChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            getFilmes(url: EnumURL.Populares)
        }
        else if sender.selectedSegmentIndex == 1{
            getFilmes(url: EnumURL.MelhoresNotas)
        }
        else if sender.selectedSegmentIndex == 2{
            getFilmes(url: EnumURL.EmCartaz)
        }
    }
    
    func getFilmes(url:EnumURL){
        let url = baseURL+url.path+api_key+endOfURL
        Alamofire.request(url).responseArray(keyPath: "results") { (response: DataResponse<[Movie]>) in
            switch response.result {
            case .success( _):
                if let movies = response.result.value{
                    self.Filmes = movies
                    self.tableview.reloadData()
                }
            case .failure(let value):
                print(value)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = segue.destination as? DetalheController{
//            cell.Filme = baseR
        }
    }
    
}

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        baseRest.getMovie(filme: indexPath.row)
        performSegue(withIdentifier: "detalheSegue", sender: indexPath)
    }
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
