# GitCat
GitCat is Native iOS application that is a Clone for the GitHub iOS Application, with searching and offline bookmarking capabilities.
GitCat is written in Swift 5.6 using the MVVM pattern.

# Features

- Live search capabilities for GitHub User, Repositries, Issues and Organizations using UISearchControllers while Exploring them.
- View commits on your favourite Repositories.
- Offline bookmarking options for Users And Repositories using CoreData and the capability of search for them Offline.
- Ability of saving Searched Words and Recently Visited Profiles
- Infinte Scrolling in lists using Pagination while Searching.
- Authenticated mode using OAuth 2.0 .
- Long Press Context Menu using UIContextMenuConfiguration for more options.
- Dark Mode Option.
- Exploring most starred Repositories written with Swift and searching in them.
- Profile tab that presents the signed in user with their information, private Repositories, starred Repositories and Organizations.

# Used Cocoapods

- Alamofire
- Kingfisher
- IQKeyboardManager

# Screenshots
![1](https://user-images.githubusercontent.com/81087849/191525704-879b5133-ff3c-4e09-b3c2-67ed6a106141.png)
![2](https://user-images.githubusercontent.com/81087849/191525738-eb29ee8b-6cda-45ae-9acc-f89892dcabe4.png)
![3](https://user-images.githubusercontent.com/81087849/191525761-41efc947-e0e7-4ec6-849d-6672748a82d9.png)
![4](https://user-images.githubusercontent.com/81087849/191525778-3174db5b-2a69-4a9f-a96f-4dd36e0573b9.png)

# Video Link 
https://www.linkedin.com/posts/mostafa-elbadawy_im-so-happy-and-proud-to-share-with-you-ugcPost-6979544915848380416-SUIV?utm_source=share&utm_medium=member_desktop

# Next Step

- Ability of deleting All Bookmarked Users, Repositories and Search Records.
- Supporting Arabic Language.

## Installation
- Open your github account and [register a new OAuth application](https://github.com/settings/applications/new)
- Clone the repository to your local device
- Set your callback URL as `gitcat://`
- If you choose a different callback URL you'll have to change your iOS app's URL scheme. Otherwise, the app won't reopen after authorization.
- Set up an GitHubConstants enum in K struct in your project in Constants file filling it with with your client ID and client Secret
```
enum GitHubConstants {
    static let clientID = "ENTER_YOUR_CLIENT_ID"
    static let clientSecret = "ENTER_YOUR_CLIENT_SECRET"
}
```
