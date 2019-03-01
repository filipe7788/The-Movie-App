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

class MainViewController: BaseViewController {
    
    var popModel = FilmesViewModel()
    var videosModel = VideoViewModel()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *){
            tableview.refreshControl = super.refreshControl
        } else {
            tableview.addSubview(super.refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(atualizar), for: .valueChanged)
        
        self.tableview.register(UINib(nibName: "movieCell", bundle: nil), forCellReuseIdentifier: "celulaFilme")
        self.popModel.getFilmes(url: EnumURL.Populares)
     
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeScene))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeScene))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }

    @objc func changeScene(_ sender:UISwipeGestureRecognizer){
        if sender.direction == .left {
            if (self.segmentedControl?.selectedSegmentIndex)! < 2 {
                self.segmentedControl?.selectedSegmentIndex += 1
            }
        } else if sender.direction == .right {
            if (self.segmentedControl?.selectedSegmentIndex)! > 0 {
                self.segmentedControl?.selectedSegmentIndex -= 1
            }
        }
        self.buscarFilmes(url: getSegmento(segmento: self.segmentedControl.selectedSegmentIndex))
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
    
    override func doBindings(){
        popModel.filmes.asObservable().bind(onNext:{ _ in
            self.tableview.reloadData()
        }).disposed(by: disposeBag)
        
        popModel.loading.asObservable().bind(onNext:{ loading in
            if loading {
                self.tableview.reloadData()
                super.startActivityIndicator()
            } else {
                self.tableview.reloadData()
                self.refreshControl.endRefreshing()
                super.stopActivityIndicator()
            }
        }).disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = segue.destination as? DetalheController{
            self.popModel.getFilme(idFilme: sender as? Int ?? 0, completion: {filme in
                cell.Filme = filme ?? ResMovie()
                cell.TituloFilme.text = filme?.Nome
                cell.bannerFilme?.image = self.popModel.getFoto(url: filme?.Banner ?? "")
                cell.Descricao.text = filme?.Descricao
                cell.DataLancamento.text = DateUtil.convertDateString(dateString: filme?.DataLancamento ?? "")
                cell.Media.text = filme?.MediaNota?.description
                cell.Status.text = filme?.Status
                cell.videosModel.getVideos(idFilme: filme?.ID ?? 0)
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
        cell?.dataLancamento.text = DateUtil.convertDateString(dateString: filme.DataLancamento)
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
