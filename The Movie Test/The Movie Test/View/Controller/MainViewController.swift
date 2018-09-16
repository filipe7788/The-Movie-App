//
//  MainViewController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 31/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import AlamofireObjectMapper

class MainViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var popModel = FilmesViewModel()
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        doBindings()
        self.popModel.getFilmes(url: EnumURL.Populares)
    }

    @IBAction func sceneChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.popModel.filmes = BehaviorRelay<[Movie]>(value: [])
            self.popModel.getFilmes(url: EnumURL.Populares)
        } else if sender.selectedSegmentIndex == 1 {
            self.popModel.filmes = BehaviorRelay<[Movie]>(value: [])
            self.popModel.getFilmes(url: EnumURL.MelhoresNotas)
        } else if sender.selectedSegmentIndex == 2 {
            self.popModel.filmes = BehaviorRelay<[Movie]>(value: [])
            self.popModel.getFilmes(url: EnumURL.EmCartaz)
        }
    }

    func doBindings(){
        popModel.filmes.asObservable().bind(onNext:{ _ in
          self.tableview.reloadData()
        }).disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = segue.destination as? DetalheController{
            cell.idFilme = sender as! Int
        }
    }
    
}

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalheSegue", sender: self.popModel.filmes.value[indexPath.row].ID)
    }
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.popModel.filmes.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "celulaFIlme", for: indexPath) as! CelulaFilme
        
        let filme = self.popModel.filmes.value[indexPath.row]
        
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

extension MainViewController: UISearchBarDelegate{
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.popModel.filmes = BehaviorRelay<[Movie]>(value: [])
        self.popModel.getFilmes(url: EnumURL.Pesquisar(searchBar.text ?? ""))
        self.view.endEditing(true)
    }
}
