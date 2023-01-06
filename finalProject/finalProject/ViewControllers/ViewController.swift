//
//  ViewController.swift
//  finalProject
//
//  Created by Иван Евсеев on 23.11.2022.
//

import UIKit
import Alamofire

var accounID: Int = 0
var sessionID: String = ""
var apiKey: String = "de2fa60445b65225004497a21552b0ce"
var userName: String = "" 


class ViewController: UIViewController {

    @IBOutlet weak var filmCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let viewModel = ViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "FilmCell", bundle: nil)
        self.filmCollectionView.register(nib, forCellWithReuseIdentifier: "FilmCell")
        let nib2 = UINib(nibName: "CollectionReusableView", bundle: nil)
        self.filmCollectionView.register(nib2, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
        let nib3 = UINib(nibName: "GenreCollectionViewCell", bundle: nil)
        self.filmCollectionView.register(nib3, forCellWithReuseIdentifier: "GenreCollectionViewCell")
        
        viewModel.getTrandingMovies {
            self.filmCollectionView.reloadData()
        }
        viewModel.getPopularMovies {
            self.filmCollectionView.reloadData()
        }
        viewModel.getTopRatedMovies {
            self.filmCollectionView.reloadData()
        }
        viewModel.getUpcomingMovies {
            self.filmCollectionView.reloadData()
        }
        viewModel.getTrandingSeries {
            self.filmCollectionView.reloadData()
        }
        viewModel.getPopularSeries {
            self.filmCollectionView.reloadData()
        }
        viewModel.getTopRatedSeries {
            self.filmCollectionView.reloadData()
        }
        viewModel.getUpcomingSeries {
            self.filmCollectionView.reloadData()
        }
        viewModel.getGenres {
            self.filmCollectionView.reloadData()
        }
        
        filmCollectionView.collectionViewLayout = createLayout()

        segmentedControl.addUnderlineForSelectedSegment()


    }
    
    @IBAction func segmentedControlPressed(_ sender: Any) {
        filmCollectionView.reloadData()
        segmentedControl.changeUnderlinePosition()
    }
    
    @IBAction func backToTopPressed(_ sender: Any) {
        filmCollectionView.setContentOffset(.zero, animated: true)
    }
    
    
    func createMainSectionLayout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 8
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(185), heightDimension: .absolute(310))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createTopSectionLayout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2) // <---
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber,_ ->
            NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                return self.createTopSectionLayout()
            } else  {
                return self.createMainSectionLayout()
            }
            
        }
    }

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            return 5
        case 1:
            return 5
        default:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = filmCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath) as! CollectionReusableView
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if indexPath.section == 1 {
                headerView.genreLabel.text = "Trending🔥"
                return headerView
            } else if indexPath.section == 2{
                headerView.genreLabel.text = "Top Rated⬆️"
                return headerView
            } else if indexPath.section == 3 {
                headerView.genreLabel.text = "Upcoming⏳"
                return headerView
            } else {
                headerView.genreLabel.text = "Popular🌎"
                return headerView
            }
        case 1:
            if indexPath.section == 1 {
                headerView.genreLabel.text = "Trending🔥"
                return headerView
            } else if indexPath.section == 2{
                headerView.genreLabel.text = "Top Rated⬆️"
                return headerView
            } else if indexPath.section == 3 {
                headerView.genreLabel.text = "Upcoming⏳"
                return headerView
            } else {
                headerView.genreLabel.text = "Popular🌎"
                return headerView
            }
        default:
            return headerView
        }
    

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if section == 0 {
                return viewModel.arrayOfMovieGenresList.count
            } else if section == 1 {
                return viewModel.arrayOfTrandingMovies.count
            } else if section == 2 {
                return viewModel.arrayOfTopRatedMovies.count
            } else if section == 3 {
                return viewModel.arrayOfUpcomingMovies.count
            } else {
                return viewModel.arrayOfPopularMovies.count
            }
        case 1:
            if section == 0 {
                return viewModel.arrayOfTVGenresList.count
            } else if section == 1 {
                return viewModel.arrayOfTrandingSeries.count
            } else if section == 2 {
                return viewModel.arrayOfTopRatedSeries.count
            } else if section == 3 {
                return viewModel.arrayOfUpcomingSeries.count
            } else {
                return viewModel.arrayOfPopularSeries.count
            }
        default:
            return 20
        }

    
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if indexPath.section == 0 {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
                cell.configure(name: viewModel.arrayOfMovieGenresList[indexPath.row].name)
                return cell
            } else if indexPath.section == 1 {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCell
                cell.configure(with: viewModel.arrayOfTrandingMovies[indexPath.row])
                return cell
            } else if indexPath.section == 2 {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCell
                cell.configure(with: viewModel.arrayOfTopRatedMovies[indexPath.row])
                return cell
            } else if indexPath.section == 3 {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCell
                cell.configure(with: viewModel.arrayOfUpcomingMovies[indexPath.row])
                return cell
            } else {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCell
                cell.configure(with: viewModel.arrayOfPopularMovies[indexPath.row])
                return cell
            }
        case 1:
            if indexPath.section == 0 {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
                cell.configure(name: viewModel.arrayOfTVGenresList[indexPath.row].name)
                return cell
            } else if indexPath.section == 1 {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCell
                cell.configureTV(with: viewModel.arrayOfTrandingSeries[indexPath.row])
                return cell
            } else if indexPath.section == 2 {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCell
                cell.configureTV(with: viewModel.arrayOfTopRatedSeries[indexPath.row])
                return cell
            } else if indexPath.section == 3 {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCell
                cell.configureTV(with: viewModel.arrayOfUpcomingSeries[indexPath.row])
                return cell
            } else {
                let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCell
                cell.configureTV(with: viewModel.arrayOfPopularSeries[indexPath.row])
                return cell
            }
        default:
            let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCell
            cell.configure(with: viewModel.arrayOfTrandingMovies[indexPath.row])
            return cell
        }
        

            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if indexPath.section == 0 {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "GenreViewController") as! GenreViewController
                viewController.typeOfMedia = "movie"
                viewController.getGenreMedia(mediaType: "movie", genreID: viewModel.arrayOfMovieGenresList[indexPath.row].id)

                
                self.navigationController?.pushViewController(viewController, animated: true)
            } else if indexPath.section == 1 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
                self.navigationController?.pushViewController(viewController, animated: true)
                
                viewController.configureMovie(with: viewModel.arrayOfTrandingMovies[indexPath.row])
            } else if indexPath.section == 2{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
                navigationController?.pushViewController(viewController, animated: true)
                
                viewController.configureMovie(with: viewModel.arrayOfTopRatedMovies[indexPath.row])
            } else if indexPath.section == 3 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
                navigationController?.pushViewController(viewController, animated: true)
                
                viewController.configureMovie(with: viewModel.arrayOfUpcomingMovies[indexPath.row])
            } else if indexPath.section == 4 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
                navigationController?.pushViewController(viewController, animated: true)
                
                viewController.configureMovie(with: viewModel.arrayOfPopularMovies[indexPath.row])
            }
            
        case 1:
            
            if indexPath.section == 0 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "GenreViewController") as! GenreViewController
                viewController.typeOfMedia = "tv"
                viewController.getGenreMedia(mediaType: "tv", genreID: viewModel.arrayOfTVGenresList[indexPath.row].id)
                
                self.navigationController?.pushViewController(viewController, animated: true)
            } else if indexPath.section == 1 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
                self.navigationController?.pushViewController(viewController, animated: true)
                
                viewController.configureSeries(with: viewModel.arrayOfTrandingSeries[indexPath.row])
            } else if indexPath.section == 2{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
                navigationController?.pushViewController(viewController, animated: true)
                
                viewController.configureSeries(with: viewModel.arrayOfTopRatedSeries[indexPath.row])
            } else if indexPath.section == 3 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
                navigationController?.pushViewController(viewController, animated: true)
                
                viewController.configureSeries(with: viewModel.arrayOfUpcomingSeries[indexPath.row])
            } else if indexPath.section == 4 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
                navigationController?.pushViewController(viewController, animated: true)
                
                viewController.configureSeries(with: viewModel.arrayOfPopularSeries[indexPath.row])
            }
        default:
            print("lala")
        }
        
        

        }


    }
    




extension UISegmentedControl {
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)

        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 188, green: 0, blue: 0, alpha: 0.5)], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)], for: .selected)
    }

    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = .red
        underline.tag = 1
        
        self.addSubview(underline)
    }

    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

extension UIImage{

    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}
