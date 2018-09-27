//
//  DetalheController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 10/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit
import RxSwift

class DetalheController: UIViewController {

    var idFilme: Int = Int()
    var model = FilmesViewModel()
    var videosModel = VideoViewModel()
    var disposeBag = DisposeBag()
    
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var TituloFilme: UILabel!
    @IBOutlet weak var bannerFilme: UIImageView!
    
    @IBOutlet weak var labelTrailer: UILabel!
    @IBOutlet weak var Titulo: UIView!
    @IBOutlet weak var Descricao: UILabel!
    @IBOutlet weak var DataLancamento: UILabel!
    @IBOutlet weak var Media: UILabel!
    @IBOutlet weak var Status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilme()
        doBindings()
        videosModel.getVideos(idFilme: self.idFilme)
        tableview.rowHeight = 228
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
    
    func doBindings(){
        videosModel.videos.asObservable().bind(onNext:{ _ in
            self.tableview.reloadData()
        }).disposed(by: disposeBag)
        
        videosModel.loading.asObservable().bind(onNext:{ loading in
            if loading {
                self.tableview.reloadData()
                // Activity Indicator
                self.activityIndicator.center = self.view.center
                self.activityIndicator.hidesWhenStopped = true
                self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                self.view.addSubview(self.activityIndicator)
                self.activityIndicator.startAnimating()
                // Start Animation
            }else {
                // Stop Animation
                self.tableview.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }).disposed(by: disposeBag)
    }
}



extension DetalheController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosModel.videos.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTrailer") as? TrailerTableViewCell
        let video = self.videosModel.videos.value[indexPath.row]
        let url = URL(string: "http://youtube.com/embed/"+(video.key ?? ""))
        cell?.webView.loadRequest(URLRequest(url: url!))
        return cell ?? TrailerTableViewCell()
    }
}
