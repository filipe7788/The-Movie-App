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
    
    var activityIndicator = UIActivityIndicatorView()
    var disposeBag = DisposeBag()
    var popModel = FilmesViewModel()
    var vdeosModel = VideoViewModel()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(atualizar), for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doBindings()
        if #available(iOS 10.0, *){
            tableview.refreshControl = refreshControl
        } else {
            tableview.addSubview(refreshControl)
        }
        self.tableview.register(UINib(nibName: "movieCell", bundle: nil), forCellReuseIdentifier: "celulaFilme")
        self.popModel.getFilmes(url: EnumURL.Populares)
    }

    @IBAction func sceneChange(_ sender: UISegmentedControl) {
        buscarFilmes(url: getSegmento(segmento: sender.selectedSegmentIndex))
    }
    
    @objc func atualizar(){
        buscarFilmes(url: getSegmento(segmento: (self.segmentedControl?.selectedSegmentIndex) ?? 0))
        searchBar.text = ""
    }
    
    func buscarFilmes(url: EnumURL){
        self.popModel.filmes = BehaviorRelay<[Movie]>(value: [])
        self.popModel.getFilmes(url: url)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getSegmento(segmento: Int) -> EnumURL{
        if segmento == 0 {
            return EnumURL.Populares
        } else if segmento == 1 {
            return EnumURL.MelhoresNotas
        } else if segmento == 2 {
            return EnumURL.EmCartaz
        }
        return EnumURL.Populares
    }
    
    func doBindings(){
        popModel.filmes.asObservable().bind(onNext:{ _ in
            self.tableview.reloadData()
        }).disposed(by: disposeBag)
        
        popModel.loading.asObservable().bind(onNext:{ loading in
            if loading {
                self.tableview.reloadData()

                self.activityIndicator.center = self.view.center
                self.activityIndicator.hidesWhenStopped = true
                self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                self.view.addSubview(self.activityIndicator)
                self.activityIndicator.startAnimating()
            } else {
                self.tableview.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }).disposed(by: disposeBag)
     
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = segue.destination as? DetalheController{
            self.popModel.getFilme(idFilme: sender as? Int ?? 0, completion: {filme in
                cell.Filme = filme ?? ResMovie()
                cell.populaFilme()
            })
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
        let cell = tableview.dequeueReusableCell(withIdentifier: "celulaFilme", for: indexPath) as? CelulaFilme

        let filme = self.popModel.filmes.value[indexPath.row]
        cell?.nome.text = filme.Nome
        cell?.descricao.text = filme.Descricao
        cell?.dataLancamento.text = filme.DataLancamento
        cell?.nota.text = filme.MediaNota?.description
        cell?.fotoFilme.image = popModel.getFoto(url: filme.Banner ?? "")
        
        return cell ?? CelulaFilme()
    }
}

extension MainViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.buscarFilmes(url: EnumURL.Pesquisar(searchBar.text?.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil) ?? ""))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.buscarFilmes(url: getSegmento(segmento: self.segmentedControl?.selectedSegmentIndex ?? 0))
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
