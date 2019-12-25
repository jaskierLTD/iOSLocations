**iOSLocations**

*WeatherAPI for every location on the earth with CoreData and Facebook registration*

![Alt text](/Screenshots/IMG_8906.PNG?raw=true "Optional Title")

**Eng**

1. Variables, constants, names of functions and identifiers start from lowercase.
2. Almost all code is divided by blocks (MARK: -) syntax. It means you can choose chapter by name at the top bar (the same line of the opened file).
3. Files separated with 3 parts: 

MODEL	(Data for usage, static parameters + Structures)
- SceneDelegate
- Result (Parsed data about the weather)
- User (Parsed user data from Facebook)
- “iOSLocations.xcdatamodeld” (CoreData model with saved weather parameters)

VIEW	(Visual part. ViewControllers for each View)
- LoginView (Sign-in page of Facebook authorization)
- ProfileView (Information about the user from Facebook to be shown after authorization)
- TableLocations (Saved names of locations with weather details)
- WeatherView (Detailed page of weather which updates with CLLocationManager)

CONTROLLER	(Brain responsible for the execution of code)
- AppDelegate (Stored API keys + CoreData save functions)
- FacebookManager (“getUserData” from a Facebook account)
- SearchResultsController (Search results from GooglePlaces for SearchBar)

4. All files are structured:
Firstly, variables and IBOutlets.
Secondly, basic functions such as viewDidLoad/viewDidAppear etc.
Finally, the implementation and created functions.

5. All brackets are aligned with the first character of the function header.
	
![Alt text](/Screenshots/pods.PNG?raw=true "Optional Title")


Instructions of use:
According to the task there are:
	◦	1.	LoginView.swift
	![Alt text](/Screenshots/IMG_8913.PNG?raw=true "Optional Title")
	◦	2.	LocationsListView (TableLocations.swift)
	![Alt text](/Screenshots/IMG_8908.PNG?raw=true "Optional Title")
	◦	3.	AddLocation (WeatherView.swift)
	![Alt text](/Screenshots/IMG_8911.PNG?raw=true "Optional Title")
	◦	4.	WeatherView also shows the weather: humidity, latitude, longtitude, location name(country, city), temperature in Fahrenheit, picture based on sky infrormation. 
	![Alt text](/Screenshots/IMG_8913.PNG?raw=true "Optional Title")
	◦	5.	ProfileView with SignOut button
	![Alt text](/Screenshots/IMG_8909.PNG?raw=true "Optional Title")

*Summary:*

The first view is signing in with Facebook.

After that shows up the tableView of locations list immediately.
At TableView the user can delete any location from the CoreData and the TableViewCells by “Swiping-left”. On the left top side, there is a “Social Profile” Bar with name, e-mail, and picture of the logged-in user. On the right top side “AddLocation” Bar to add new location/review chosen one from the current tableView.

AddLocation. The search bar is above the view, where the user can choose any location name in any preferred language. The weather information about the chosen one will appear after a while.


**Ua**

1. Змінні, константи, назви функцій та ідентифікатори починаються з малих літер.
2. Майже весь код розділений синтаксисом блоків (MARK: -). Це означає, що ви можете вибрати розділ за назвою у верхній панелі (той самий рядок відкритого файлу).
3. Файли, розділені на 3 частини:

MODEL (Дані для використання, статичні параметри + Структури)
- SceneDelegate
- Result (Проаналізовані дані про погоду)
- User (Аналіз даних користувача з Facebook)
- “iOSLocations.xcdatamodeld” (модель CoreData із збереженими параметрами погоди)

VIEW (Візуальна частина. ViewControllers для кожного View)
- LoginView (сторінка входу в авторизацію Facebook)
- ProfileView (Інформація про користувача з Facebook повинна відображатися після авторизації)
- TableLocations (збережені назви місць із деталями погоди)
- WeatherView (детальна сторінка погоди, яка оновлюється за допомогою CLLocationManager)

CONTROLLER (Мозок, відповідальний за виконання коду)
- AppDelegate (збережені ключі API + функції збереження CoreData)
- FacebookManager ("getUserData" з облікового запису Facebook)
- SearchResultsController (результати пошуку з GooglePlaces для SearchBar)

4. Усі файли структуровані:
В першу чергу, змінні та IBOutlets.
По-друге, основні функції, такі як viewDidLoad / viewDidAppear і т.д.
Нарешті, реалізація та створені функції.

5. Усі дужки вирівняні з першим символом заголовка функції.

Інструкція по застосуванню:
Відповідно до завдання є:
◦ 1. LoginView.swift
◦ 2. LocationsListView (TableLocations.swift)
◦ 3. AddLocation (WeatherView.swift)
◦ 4. WeatherView також показує погоду: вологість, широту, довготу, назву місця (країна, місто), температуру в Фаренгейті, малюнок на основі інформації про небо.
◦ 5. ProfileView за допомогою кнопки SignOut

*Підсумок:*

Перший погляд - це вхід у Facebook.

Після цього негайно з'являється tableView список місць.
У TableView користувач може видалити будь-яке місце з CoreData та TableViewCells за допомогою "Проведення вліво". У лівій верхній частині розміщено кнопку "Соціальний профіль" з ім'ям, електронною поштою та зображенням зареєстрованого користувача. У верхній правій частині панелі “AddLocation", щоб додати нове місце розташування / обраний огляд із поточної таблиці View.

AddLocation. Рядок пошуку знаходиться над вікном перегляду, де користувач може вибрати будь-яку назву місцезнаходження будь-якою бажаною мовою. Інформація про погоду про вибраного з’явиться через деякий час.
