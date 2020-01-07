
//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import Foundation

class JsonHelper {
    
    public static func getVideosCategoryList() -> [Root]? {
        var videoCategoryList = [Root]()
        let url = Bundle.main.url(forResource: Constants.Key.JsonKeys.jsonFileNameKey, withExtension: Constants.Key.JsonKeys.fileExtention)!
        do {
            let jsonData = try Data(contentsOf: url)
            let jsonDataArray = try JSONSerialization.jsonObject(with: jsonData) as! [Any]
            for dic in jsonDataArray {
                var nodeList = [Node]()
                let dd  = dic as! [String:Any]
                let nodes = dd[Constants.Key.JsonKeys.nodesKey] as! [[String:Any]];
                let title = dd[Constants.Key.JsonKeys.titleKey];
                var rootClass = Root()
                for vidDic in nodes {
                    let dd  = vidDic
                    let videoData = dd[Constants.Key.JsonKeys.videoKey] as! [String:Any];
                    let encodeUrl = videoData[Constants.Key.JsonKeys.encodeUrlKey];
                    var nodeModel = Node();
                    var video = Video();
                    video.encodeUrl = encodeUrl as? String;
                    nodeModel.video = video;
                    nodeList.append(nodeModel);
                }
                rootClass.nodes = nodeList
                rootClass.title = title as? String;
                videoCategoryList.append(rootClass);
            }
            return videoCategoryList;
        }
        catch {
            print(error)
        }
        return nil;
    }
}
