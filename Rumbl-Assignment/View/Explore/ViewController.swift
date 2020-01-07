
//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var videoCategoryList : [Root]?
    
    @IBOutlet weak var tableView: UITableView!
    
    let headerReuseId = "TableHeaderViewReuseId"
    
    var imageCacheLoader : ImageLoader?
    
    private let refreshControl = UIRefreshControl()


    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.title = Constants.Titles.Explore;
        imageCacheLoader = ImageLoader();
        let headerNib = UINib(nibName: Constants.CellIdentifiers.CustomHeaderView, bundle: nil)
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerReuseId)
        AddRefrechControl()
        ProcessJsonData()
        self.tableView.reloadData()
        tableView.separatorColor = UIColor.clear
    }
    
    func AddRefrechControl(){
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.25, alpha:1.0)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        ProcessJsonData()
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: Data initlisers methods
    func ProcessJsonData() {
    videoCategoryList = JsonHelper.getVideosCategoryList();
    }
    
    //MARK:Tableview Delegates and Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return  videoCategoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Size.TableViewHeight;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.CustomTableViewCell) as? CustomTableViewCell
        if cell == nil {
            cell = CustomTableViewCell.customCell
        }
        let root = (self.videoCategoryList?[indexPath.section])!
        cell?.updateCellWith(root: root, imageCache: imageCacheLoader!)
        cell?.cellDelegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.Size.HeightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseId) as? CustomHeaderView
        if view == nil {
            view = CustomHeaderView.customView
        }
        let root = self.videoCategoryList?[section]
        view?.headerLabel.text = root?.title
        return view
    }
}

extension ViewController:CustomCollectionCellDelegate {
    func collectionView(collectioncell: CustomCollectionViewCell?, didTappedInTableview TableCell: CustomTableViewCell) {
        if let selectedRoot = TableCell.rootModel {
            let storyBoard = UIStoryboard(name: Constants.CellIdentifiers.Main, bundle: nil)
            let detailController = storyBoard.instantiateViewController(withIdentifier:Constants.CellIdentifiers.DetailViewController) as? DetailViewController
            detailController?.rootModel = selectedRoot
            self.navigationController?.pushViewController(detailController!, animated: true)
        }
    }
}
