//
//  CategoryCell.swift
//  HangulTracing
//
//  Created by junwoo on 2017. 11. 18..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit

class DeleteBtn: UIButton {
  var parentCell: UICollectionViewCell?
}

class CategoryCell: UICollectionViewCell {
  var deleteBtnDelegate: DeleteBtnDelegate?
  var titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = UIColor(hex: "65418F")
    return label
  }()
  var deleteBtn: DeleteBtn = {
    let btn = DeleteBtn()
    btn.setImage(UIImage(named: "delete"), for: .normal)
    return btn
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = UIColor(hex: "FED230")
    contentView.layer.cornerRadius = 15
    contentView.clipsToBounds = true
    contentView.addSubview(titleLabel)
    contentView.addSubview(deleteBtn)
    deleteBtn.isHidden = true
    deleteBtn.parentCell = self
    deleteBtn.addTarget(self, action: #selector(CategoryCell.deleteBtnTapped), for: .touchUpInside)
    
    titleLabel.snp.makeConstraints { (make) in
      make.edges.equalTo(contentView)
    }
    
    deleteBtn.snp.makeConstraints { (make) in
      make.left.top.equalTo(contentView)
      make.width.height.equalTo(40)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configCell(category: Category, cellMode: CellMode) {
    if cellMode == .normal {
      deleteBtn.isHidden = true
    } else {
      deleteBtn.isHidden = false
      wiggle()
    }
    titleLabel.text = category.title
  }
  
  @objc func deleteBtnTapped() {
    self.deleteBtnDelegate?.deleteBtnTapped(sender: deleteBtn)
  }
  
}
