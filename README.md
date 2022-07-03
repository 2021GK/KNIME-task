# KNIME-challene
KNIME interview challenge


## Before starting

1. Make sure you have Python3 installed. Check the version with `python --version`
2. Install the needed libraries:
- `pip install robotframework`
- `pip install selenium`
- `pip install robotframework-seleniumlibrary`
3. Clone this repo by running `git clone ...`
4. Navigate to the project's folder

## How to run tests

There are 4 tests available in the project. For each test the username and the password for the KNIME hub need to be provided, as demonstrated below

1. Create Space Test
In the command line run: `robot -v USERNAME:<your KNIME username> -v PASSWORD:<your KNIME password> -t "Create Space Test" .`

2. Delete Single Space Test
In the command line run: 
`robot -v USERNAME:<your KNIME username> -v PASSWORD:<your KNIME password> SPACE_TO_DELETE:<name you want the space to have> -t "Delete Single Space Test" .`

3. Create Multiple Spaces Test
In the command line run:
`robot -v USERNAME:<your KNIME username> -v PASSWORD:<your KNIME password> -v num:<optional: the number of spaces you want to create> sp_type:<optional: 1 for private, 2 for public> "Create Multiple Spaces Test" .`

4. Delete All Spaces Test
In the command line run:
`robot -v USERNAME:<your KNIME username> -v PASSWORD:<your KNIME password> -t "Delete All Spaces Test" .` 


## Important note

While running the tests you might get an error regarding the WebDriver.

Here are some tips on how to overcome the problem:

1. Chrome
- go to https://chromedriver.chromium.org/home
- download the latest release
- after unzipping the file, copy the chromedriver.exe to a folder which is in the PATH

2. Safari
- go to https://developer.apple.com/documentation/webkit/testing_with_webdriver_in_safari
- follow the instructions in the "WebDriver Support" section
(keep in mind, if you want to use Safari for testing, you will need to modify the ${BROWSER} variable in test1.robot)



## Manual test cases



| ID   | Summary                  | Preconditions                                                                                                                                                                                                                                                                                                             | Steps                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | Expected results                                                                                                                                                                                   | Actual results   | Status |
| ---- | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- | ------ |
| KH-1 | Creating a new space     | The user should create a<br>Knime hub account prior.<br><br>"USERNAME" and "PASSWORD" variables must be provided.<br><br>If the "space\_type" variable is<br>not specified, the default<br>value is 1 (private)                                                                                                           | 1\. Go to the KNIME hub page (https://hub.knime.com/)<br>2\. Accept cookies<br>3\. Click the "sign in" button in the upper-right corner<br>4\. Enter the user credentials<br>5\. Click the avatar icon in the upper-right corner<br>6\. Select "Spaces" from the dropdown<br>7\. Create a public/private space by clicking on the respective button in the "Create new space" section<br>8\. Save the space name by clicking on the checkbox button<br>9\. Navigate back to the "Spaces" page<br>                                                                   | Result: "Your new space<br>was created successfully!"<br>message is shown; A new card is created for the space on "Spaces" page                                                                    | Same as expected | PASS   |
| KH-2 | Deleting a space         | The user should create a<br>Knime hub account prior.<br><br>"USERNAME" and "PASSWORD" variables must be provided.<br><br>The name of the space to be deleted must be defined through the "SPACE\_TO\_DELETE" variable.                                                                                                    | 1\. Go to the KNIME hub page (https://hub.knime.com/)<br>2\. Accept cookies<br>3\. Click the "sign in" button in the upper-right corner<br>4\. Enter the user credentials.<br>5\. Click the avatar icon in the upper-right corner<br>6\. Select "Spaces" from the dropdown<br>7\. Choose the space that needs to be deleted by clicking on the respective card<br>8\. Click the option "More" (three vertical dots)<br>9\. On the displayed bubble click "Delete space"<br>10\. Enter the name of the space in the input field of the modal overlay and confirm<br> | Result: Navigated back to the "Spaces" page, the deleted space is not on the list and "Space was deleted successfully!"<br> message is displayed<br>                                               | Same as expected | PASS   |
| KH-3 | Creating multiple spaces | The user should create a<br>Knime hub account prior.<br><br>"USERNAME" and "PASSWORD" variables must be provided.<br><br>If the "space\_type" variable is<br>not specified, the default<br>value is 1 (private)<br><br>If the "num" variable is not<br>specified (number of spaces to<br>create), the default value is 2. | 1\. Go to the KNIME hub page<br>2\. Accept cookies<br>3\. Click the "sign in" button in the upper-right corner<br>4\. Enter the user credentials<br>5\. Click the avatar icon in the upper-right corner<br>6\. Select "Spaces" from the dropdown<br>7\. Create a public/private space by clicking on the respective button in the "Create new space" section<br>8\. Save the space name by clicking on the checkbox button<br>9\. Navigate back to the "Spaces" page<br>10\. Repeat steps 7-9 until the desired number of spaces is created                         | Result: "Your new space<br>was created successfully!"<br>message is shown after each created space; A new card is created for the space on "Spaces" page for each new space.                       | Same as expected | PASS   |
| KH-4 | Deleting all spaces      | The user should create a<br>Knime hub account prior.<br><br>"USERNAME" and "PASSWORD" variables must be provided.                                                                                                                                                                                                         | 1\. Go to the KNIME hub page<br>2\. Accept cookies<br>3\. Click the "sign in" button in the upper-right corner<br>4\. Enter the user credentials.<br>5\. Click the avatar icon in the upper-right corner<br>6\. Select "Spaces" from the dropdown<br>7\. Choose a space to be deleted<br>8\. Click the option "More" (three vertical dots)<br>9\. On the displayed bubble click "Delete space"<br>10\. Enter the name of the space in the input field of the modal overlay and confirm<br>11\. Repeat steps 7-10 until all spaces are deleted                       | Result: Navigated back to the "Spaces" page after each deleted space; the deleted space is not on the list and "Space was deleted successfully!" message is displayed after each deleted space<br> | Same as expected | PASS   |





## Second task: bug tracking

| ID          | Summary                                                | Description                                                                                                                                                | Evidence           |
| ----------- | ------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| BUG\_01     | Share icon is shown for private spaces                 | The "share" icon in the<br>bottom-left corner of the<br>space's card is shown for<br>private spaces, when it<br>should only be shown for<br>private spaces | Screenshot\_01.png |
| BUG\_02     | Spaces are not in order                                | The spaces are shown<br>in no particular order and they shuffle on refresh                                                                                 | Screenshot\_02.png |
| BUG\_03<br> | Icons not working                                      | None of the icons at the<br>bottom of the spaces<br>cards are functional<br>(out of scope?)                                                                |                    |
| BUG\_04<br> | The footer does not match the sample<br>screen capture | (out of scope?)                                                                                                                                            |                    |

![alt text]()
![alt text]()
