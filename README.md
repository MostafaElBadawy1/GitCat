# GitCat
GitCat is Native iOS application that is a Clone for the GitHub iOS Application, with searching and offline bookmarking capabilities.
GitCat is written in Swift 5.6 using the MVVM pattern.

# ScreenShots

![IMG_2907](https://user-images.githubusercontent.com/81087849/191144944-977df645-a846-4670-a7b0-47ca2f06f1d9.PNG)
![IMG_2908](https://user-images.githubusercontent.com/81087849/191144946-704c08aa-c4a6-45ed-a232-192dae8959bb.PNG)
![IMG_2909](https://user-images.githubusercontent.com/81087849/191144951-a9a89ecd-9744-445d-a1c0-8ca128a11b96.PNG)
![IMG_2910](https://user-images.githubusercontent.com/81087849/191144956-e0725dcf-be57-4b7e-9f2b-c143363c1f60.PNG)
![IMG_2914](https://user-images.githubusercontent.com/81087849/191144961-43e8c973-b4db-4f8d-92c3-d8ffdb5489ad.PNG)
![IMG_2915](https://user-images.githubusercontent.com/81087849/191144963-cf5ed3b6-f78d-4fac-ade2-198f3512110f.PNG)
![IMG_2918](https://user-images.githubusercontent.com/81087849/191144967-27b65157-3413-45aa-a006-0a7874c45f5b.PNG)
![IMG_2919](https://user-images.githubusercontent.com/81087849/191144977-5fa7ef61-63fd-43ec-b819-2bac5589d32b.PNG)
![IMG_2920](https://user-images.githubusercontent.com/81087849/191144984-a9c46700-663a-4206-bcef-94b4e35ef195.PNG)
![IMG_2921](https://user-images.githubusercontent.com/81087849/191144992-98a1b087-e9fe-40a6-8f63-5d52121fff4d.PNG)
![IMG_2922](https://user-images.githubusercontent.com/81087849/191144994-2d688a21-2021-4b36-996a-e9f7ff9f2796.PNG)
![IMG_2924](https://user-images.githubusercontent.com/81087849/191144997-c8bd3a45-1c92-4cbe-a7ba-6ac1adc30767.PNG)
![IMG_2925](https://user-images.githubusercontent.com/81087849/191145001-936ad428-0747-41ce-858f-36c1806dfe1c.PNG)

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
