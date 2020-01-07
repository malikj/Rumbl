//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate  {
    
    var rootModel:Root?
    
    @IBOutlet weak var tableView: UITableView!
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer.isEqual(self.navigationController?.interactivePopGestureRecognizer) else{ return true }
        let pointofTouch = gestureRecognizer.location(in: self.view)
        let indexPath = IndexPath(row: 3, section: 0)
        let rect = tableView.rectForRow(at: indexPath)
        if rect.contains(pointofTouch){
            return false
        }else{
            return true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.Titles.PlayerScreen;
         tableView.separatorInset = .zero
         tableView.layoutMargins = .zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (rootModel?.nodes.count)!;
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let cell = cell as! CustomVideoPlayCell
//        let node = (rootModel?.nodes?[indexPath.row])!
//        cell.updateCellWithVideo(name: node.video);
//        if(indexPath.row == 0){ // Play first video asap
//            cell.videoView.play()
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.CustomVideoPlayCell) as? CustomVideoPlayCell
        if cell == nil {
            cell = CustomVideoPlayCell.customCell
        }
        cell?.videoView.delegate = self;
        let node = (rootModel?.nodes?[indexPath.row])!
        cell?.updateCellWithVideo(name: node.video);
        if(indexPath.row == 0){ // Play first video asap
            cell?.videoView.play()
        }
        return cell!
    }
}

extension DetailViewController : BackClickDelegate {
    
    func BackClicked() {
        self.navigationController?.popViewController(animated: true);
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkWhichVideoToPlay();
    }
    
    func checkWhichVideoToPlay() {
        for cell in tableView.visibleCells {
            if cell.isKind(of: CustomVideoPlayCell.self) {
                let indexpath = tableView.indexPath(for: cell);
                let cellRect = tableView.rectForRow(at: indexpath!)
                let superview = tableView.superview;
                let converRect = tableView.convert(cellRect, to: superview);
                let intersect = tableView.frame.intersection(converRect)
                let visibleHeight = intersect.height;
                let customVideoPlayCell = cell as! CustomVideoPlayCell
                if(visibleHeight>customVideoPlayCell.videoView.frame.height*0.8) //  play when 80% of the cell is visible
                {
                    customVideoPlayCell.videoView.play()
                }
                else {
                    customVideoPlayCell.videoView.stop()
                }
            }
        }
    }
    
}

