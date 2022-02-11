//
//  SCImagePicker.swift
//  SCImagePicker
//
//  Created by wow_mec on 2022/02/09.
//

import UIKit
import Photos


// TODO: - delegate 적용해서 이벤트 연동하기
// TODO: - 배포할때 public 제거하기
public class SCImagePicker: UIView, UICollectionViewDataSource {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var finishButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageManager = PHCachingImageManager()
    var fetchResult: PHFetchResult<PHAsset>!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadXib()
        viewInitializer()
    }
    
    private func loadXib() {
        let bundle = Bundle(for: SCImagePicker.self)
        let view = bundle.loadNibNamed("SCImagePicker", owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
    private func viewInitializer() {
        backButton.action = #selector(didSelectBackButton)
        finishButton.action = #selector(didSelectFinishButton)
        
        let assets = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        guard let album = assets.firstObject else { return }
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: album, options: options)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "SCImagePickerCell", bundle: Bundle(for: SCImagePickerCell.self)), forCellWithReuseIdentifier: "cell")
        
        setLayout()
    }
    
    private func setLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let size = self.collectionView.frame.width / 3 - 1
        layout.itemSize = CGSize(width: size, height: size)
        self.collectionView.collectionViewLayout = layout
    }
    
    @objc func didSelectBackButton(sender: UIBarButtonItem) {
        print("+")
    }
    
    @objc func didSelectFinishButton(sender: UIBarButtonItem) {
        print("+")
    }
    
    

}

// MARK: - Extensions
extension SCImagePicker: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SCImagePickerCell
        
        let asset = fetchResult.object(at: indexPath.item)
        
        imageManager.requestImage(for: asset,
                                     targetSize: CGSize(width: asset.pixelWidth / 3, height: asset.pixelHeight / 3),
                                     contentMode: .aspectFill,
                                     options: nil) { (image, _) in
            cell.imageView.image = image
        }
        
        return cell
    }
    
    

}
