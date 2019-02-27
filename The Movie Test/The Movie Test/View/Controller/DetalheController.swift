//
//  DetalheController.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 10/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit
import RxSwift

class DetalheController: BaseViewController {

    var Filme: ResMovie = ResMovie()
    
    var videosModel = VideoViewModel()
    
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
    
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var labelLançamento: UILabel!
    @IBOutlet weak var labelMedia: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelTrailers: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopActivityIndicator()
        labelMedia.text = "Média"
        labelDescricao.text = "Descrição"
        labelStatus.text = "Status"
        labelTrailer.text = "Trailers"
        labelLançamento.text = "Data de Lançamento"
    }
    
    override func viewWillAppear(_ animated: Bool) {
       startActivityIndicator()
    }
    
    override func doBindings(){

        videosModel.videos.asObservable().bind(onNext:{ _ in
            self.tableview.reloadData()
        }).disposed(by: disposeBag)
        
        videosModel.loading.asObservable().bind(onNext:{ loading in
            if loading {
                super.startActivityIndicator()
            } else {
                self.refreshControl.endRefreshing()
                super.stopActivityIndicator()
            }
            self.tableview.reloadData()
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
