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

    var Filme: ResMovie = ResMovie()
    var model = FilmesViewModel()
    var videosModel = VideoViewModel()
    var disposeBag = DisposeBag()
    
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
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
        doBindingsVideo()
    }
    
    func populaFilme(){
        self.TituloFilme.text = self.Filme.Nome
        self.bannerFilme?.image = self.model.getFoto(url: Filme.Banner ?? "")
        self.Descricao.text = self.Filme.Descricao
        self.DataLancamento.text = self.Filme.DataLancamento
        self.Media.text = self.Filme.MediaNota?.description
        self.Status.text = self.Filme.Status
        videosModel.getVideos(idFilme: self.Filme.ID ?? 0)
    }
    
    func doBindingsVideo(){
        videosModel.videos.asObservable().bind(onNext:{ _ in
            self.tableview.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func startActivityIndicator(){
        self.activityIndicator.center = self.scrollView.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.scrollView.addSubview(self.activityIndicator)
        activityIndicator.startAnimating()
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
