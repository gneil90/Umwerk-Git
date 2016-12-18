### Task:
Show a list of all Java developers from Github, two targets with different background, today extension.

### Intro:
Project uses CocoaPods dependency manager, please, run pod install command in your terminal and open .xcworkspace file.
If you do not have CocoaPods installed on your machine, please, use following [their getting start guide](https://guides.cocoapods.org/using/getting-started.html). Deployment target: iOS > 9.0
In order to prove the knowledge in Objective-C && Swift, I interoperate these two languages in project. 

### Limits:
GitHub api has [rate limit](https://developer.github.com/v3/rate_limit/) rules, to extend it I sign every request with client_id and client_secret. For authenticated requests, you can make up to 30 requests per minute.

To share the data across the extensions and containing app, I have set up AppGroups in my apple dev account with id: __group.umwerk.widgetSharingDefaults__ One should change this id according to provisioning profile before project build OR ask me to distribute beta build.

### Docs

###### Classes:

__GitHubService__ - executes all github related requests in background

__UWKAppGroupsManager__ - reads/writes from userdefaultssuite to share data between extensions and app

__IconDownloader__ -  Helper object for managing the downloading of a particular app's icon.
  It uses NSURLSession/NSURLSessionDataTask to download the app's icon in the background if it does not
  yet exist and works in conjunction with the RootViewController to manage which apps need their icon.
__GitHubUser__ - subclass of [JSONModel](https://github.com/jsonmodel/jsonmodel) allows rapidly to parse JSON input into class.

__GitHubRequest__ - constructing url-request to github-api, automatically signs every request with client_id and client_secret.

__UWKMobileClient__ - configures third-party services, theme styles, from application delegate with options.

__UWKUserListViewController__ - view controller to show list of java language users 

__UWKUserViewController__ - view controller to show details of particular user

###### Preprocessor Flags:

__UWK_BLUE__ - defined only for Umwerk-git-blue target, allows to use #ifdef 

###### Categories:

__UIColor+UWKTheme__ - contains all theme related colors


### Demo:

![Alt Text](https://github.com/gneil90/Umwerk-Git/blob/master/Umwerk-Git/Preview/ezgif.com-optimize.gif)
![Alt Text](https://github.com/gneil90/Umwerk-Git/blob/master/Umwerk-Git/Preview/email.gif)
![Alt Text](https://github.com/gneil90/Umwerk-Git/blob/master/Umwerk-Git/Preview/widget.gif)
![Alt Text](https://github.com/gneil90/Umwerk-Git/blob/master/Umwerk-Git/Preview/black_background.gif)

