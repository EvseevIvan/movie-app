# movie-app

Used data-base: https://www.themoviedb.org/. MVVM + UIKit.
Libraries: youtube-ios-player-helper, Alamofire, SDWebImage.



AuthenticationViewController:

<img width="352" alt="image" src="https://user-images.githubusercontent.com/120016619/212478774-3d27a186-3ee3-4995-9991-9b572e673912.png">

Used post requests. (Alamofire). it is also possible to form of liogin "login like a guest", which does not allow adding to favorites and does not load the list of favorites.







ListViewController:

<img width="355" alt="image" src="https://user-images.githubusercontent.com/120016619/212478881-12ae7bc6-59d1-4803-b322-080e98140f6c.png">

Used UICollectionViewCompositionalLayout, when you click on a cell with a genre, a tableView with films of the genre is displayed. Segmented control. Back to top button. 





FilmDetailsViewController:

<img width="353" alt="image" src="https://user-images.githubusercontent.com/120016619/212479067-4dec3921-d09c-45d4-acb1-cff5a1a2b56a.png">

The controller is configured by clicking on the cell, the tailer loads from YouTube with "youtube-ios-player-helper". Add to favorites button that changes her color regardless of which controller the movie was deleted from.



SearchViewController:

<img width="346" alt="image" src="https://user-images.githubusercontent.com/120016619/212479383-f228ba54-45df-4bfc-a7e1-d4829c065824.png">

Every time the text in the search string changes, a query is executed.




FavouritesViewController:

<img width="353" alt="image" src="https://user-images.githubusercontent.com/120016619/212479522-341ea748-c0a4-4919-a4db-d1187c9dd550.png">

Page with favorites which implemented removal by swipe.



ProfileViewController:

Displays the name of the account and its number, if the guest has clicked, displays "Guest session". Logout button.


