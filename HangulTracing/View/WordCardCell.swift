//
//  WordCardCell.swift
//  HangulTracing
//
//  Created by junwoo on 2017. 11. 8..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit

protocol DeleteBtnDelegate: class {
  func deleteBtnTapped(sender: UIButton)
}

extension DeleteBtnDelegate {
  func deleteBtnTapped(sender: UIButton) {}
}

class WordCardCell: UICollectionViewCell {
  
  weak var deleteBtnDelegate: DeleteBtnDelegate?
  
  var imgView: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFill
    return imgView
  }()
  var deleteBtn: UIButton = {
    let btn = UIButton()
    btn.setImage(UIImage(named: "delete"), for: .normal)
    return btn
  }()
  var wordLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = UIColor(hex: "1EC545")
    label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.layer.cornerRadius = 15
    contentView.layer.masksToBounds = true
    contentView.addSubview(imgView)
    contentView.addSubview(wordLabel)
    contentView.addSubview(deleteBtn)
    deleteBtn.isHidden = true
    deleteBtn.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
    
    wordLabel.snp.makeConstraints { (make) in
      make.left.equalTo(contentView).offset(2)
      make.right.bottom.equalTo(contentView).offset(-2)
      make.height.equalTo(50)
    }

    imgView.snp.makeConstraints { (make) in
      make.left.top.equalTo(contentView).offset(2)
      make.right.equalTo(contentView).offset(-2)
      make.bottom.equalTo(wordLabel.snp.top).offset(-2)
    }
    deleteBtn.snp.makeConstraints { (make) in
      make.left.top.equalTo(contentView)
      make.width.height.equalTo(40)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configCell(card: WordCard, cellMode: CellMode) {
    
    if cellMode == .normal {
      deleteBtn.isHidden = true
    } else {
      deleteBtn.isHidden = false
    }
    wordLabel.text = card.word
    wordLabel.font = UIFont(name: "NanumBarunpen", size: 14)!
    imgView.image = UIImage(data: card.imgData)
  }
  
  @objc func deleteBtnTapped() {
    self.deleteBtnDelegate?.deleteBtnTapped(sender: deleteBtn)
  }
}
