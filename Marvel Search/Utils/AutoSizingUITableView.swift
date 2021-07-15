//
//  AutoSizingUITableView.swift
//  Marvel Search
//
//  Created by Guilherme Golfetto on 14/07/21.
//

import UIKit

class AutoSizingUITableView: UITableView {

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize() //invalidando o intrict size da table view
            //intrict == valor default
        }
    }
    
    override var intrinsicContentSize: CGSize {
        //baseado no conteudo ele vai dizer o tamanho das contraints para a tableview
        layoutIfNeeded() //forçando para ele forçar o tamanho
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

}
