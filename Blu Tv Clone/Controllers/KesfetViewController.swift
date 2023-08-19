//
//  KesfetViewController.swift
//  Blu Tv Clone
//
//  Created by Berna Şener on 19.08.2023.
//

import UIKit



enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}



class KesfetViewController: UIViewController  {

    
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.backgroundColor = .black
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        headerView = HeroHeaderUIView (frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        
    }
    
    
    private func configureNavbar() {
        /*
        var image = UIImage(named: "BluTvLogo 1")
                image = image?.withRenderingMode(.alwaysOriginal)
         */
        
        navigationItem.title = ""
        let logoImageView = UIImageView(image: UIImage(named: "BluTvLogo 1"))
        logoImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImageView
        let imageSize = CGSize(width: 70, height: 70)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        
               // UIBarButtonItem(image: image, style: .done, target: self, action: nil),
                //UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil),
                //UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .done, target: self, action: nil),
                //UIBarButtonItem(image: UIImage(systemName: "person.3.sequence"), style: .done, target: self, action: nil)
                
                
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .done, target: self, action: nil)
         
        
                
               // navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
    
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .black
        
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }


    
}



// MARK: - TableView Delegate and DataSource Methods
extension KesfetViewController:  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies {result in
                switch result{
                case.success(let titles):
                    cell.configure(with:titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs {result in
                switch result{
                case.success(let titles):
                    cell.configure(with:titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular {result in
                switch result{
                case.success(let titles):
                    cell.configure(with:titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies {result in
                switch result{
                case.success(let titles):
                    cell.configure(with:titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated {result in
                switch result{
                case.success(let titles):
                    cell.configure(with:titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
           guard let header = view as? UITableViewHeaderFooterView else {return}
           header.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
           header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
           header.textLabel?.textColor = .white
           //header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
       }
       
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return sectionTitles[section]
       }
       
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let defaultOffset = view.safeAreaInsets.top
           let offset = scrollView.contentOffset.y + defaultOffset
           
           navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
       }
   }

   
