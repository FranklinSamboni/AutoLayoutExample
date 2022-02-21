//
//  ViewController.swift
//  AutoLayoutExample
//
//  Created by Franklin Samboni on 14/02/22.
//

import UIKit

enum Cells {
    case Cell1
    case Cell2
    case Cell3
    case Cell4
}

class Model {
}

struct HomeData {
    let cell: Cells
    let leading: CGFloat
    let trailing: CGFloat
}

class Presenter {
    let templateIphonePotrait : [Cells] =  [.Cell1, .Cell2, .Cell2, .Cell3]
    
    let template : [Cells] =  [.Cell1, .Cell4, .Cell2, .Cell2]
    
    let count = 40
    
    func getModel() -> [HomeData] {
        var data = [HomeData]()
        
        for index in 0 ..< count {
            
            var mod = index
            
            if mod >= getTemplate().count {
                mod %= getTemplate().count
            }
            
            let item = getTemplate()[mod]
            
            if mod == 1 {
                data.append(HomeData(cell: item, leading: 8, trailing: 4))
            } else if mod == 2 {
                data.append(HomeData(cell: item, leading: 4, trailing: 8))
            } else {
                data.append(HomeData(cell: item, leading: 0, trailing: 0))
            }
        }
        
        //getTemplate().enumerated().forEach { index, item in
        return data
    }
    
    func getTemplate() -> [Cells] {
        let isIphonePortrait = UIDevice.current.userInterfaceIdiom == .phone && UIApplication.shared.statusBarOrientation.isPortrait
        return isIphonePortrait ? templateIphonePotrait : template
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let presenter = Presenter()
    
    var template: [Cells] {
        presenter.template
    }
    
    var models: [HomeData] {
        return presenter.getModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(UINib(nibName: "Cell1", bundle: nil), forCellWithReuseIdentifier: "Cell1")
        collectionView.register(UINib(nibName: "Cell2", bundle: nil), forCellWithReuseIdentifier: "Cell2")
        collectionView.register(UINib(nibName: "Cell3", bundle: nil), forCellWithReuseIdentifier: "Cell3")
        collectionView.register(UINib(nibName: "Cell4", bundle: nil), forCellWithReuseIdentifier: "Cell4")

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        DispatchQueue.main.async { [weak self] in
            self?.collectionView.collectionViewLayout.invalidateLayout()
            self?.collectionView.reloadData()
        }
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = models[indexPath.row]
        let item = models[indexPath.row].cell
        switch item {
        case .Cell1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as! Cell1
            cell.backgroundColor = .brown
            return cell
        case .Cell2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! Cell2
            cell.containerView.backgroundColor = .red
            cell.leading.constant = model.leading
            cell.trailing.constant =  model.trailing
            
            return cell
        case .Cell3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell3", for: indexPath) as! Cell3
            cell.backgroundColor = .brown
            return cell
        case .Cell4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell4", for: indexPath) as! Cell4
            cell.backgroundColor = .red
            return cell
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let isIphonePortrait = UIDevice.current.userInterfaceIdiom == .phone && UIApplication.shared.statusBarOrientation.isPortrait

        let item = models[indexPath.row].cell
        let availableWidth = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        
        switch item {
        case .Cell1, .Cell3:
            return CGSize(width: collectionView.frame.width, height: 200)
        case .Cell2:
            let width = isIphonePortrait ? (availableWidth * 0.5) : (availableWidth * 0.25)
            return CGSize(width: width, height: 200)
        case .Cell4:
            return CGSize(width: (availableWidth * 0.5), height: 200)
        }
    }
    
}
