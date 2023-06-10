# bardchat

A cross-platform front end for using the currently unofficial Bard API locally on your devices.
This app is currently built to be run on the same local device which runs the [bardchat-python](https://github.com/thecodekitchen/bardchat-python) backend.
Soon, I will be providing Terraform scripts for various cloud deployment strategies which would theoretically enable a working mobile build by targeting the endpoint for your cloud deployment in 
main.dart and running
```
flutter build android
```
or
```
flutter build ios
```

# Instructions For Local Use

##Step 1:
Clone this repo and cd into it.

##Step 2:
While I have provided an example build, you should probably run
```
flutter run build linux --release
```
rather than using my binary in case your machine prefers a different configuration and for security in general.

After that, copy the contents of build/linux/x64/release/bundle to a directory of your choice.
This will be your installation directory for your front end application.

You can then delete the rest of the repository since that's all you need to run the front end locally.
Keep it around if you want to experiment with your own cross-platform builds and deployment strategies.

##Step 3:
If you chose to follow [these instructions](https://github.com/thecodekitchen/bardchat-python/blob/master/README.md) to activate the backend, you can simply run the binary file from your installation directory after activating it successfully.

NOTE: This was necessary since the unofficial API I found for chatting with Bard was in Python, not Dart. However, since I really enjoy working between these tools, I'm considering assembling a formal toolkit that integrates them automatically and calling it the Flython stack.

Alternatively, follow the next optional step to streamline the startup process.

##Step 3.5 (optional):
Install [Docker and Docker Compose](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-install-Docker-and-docker-compose-on-Ubuntu) locally if you haven't already.
Then, download the docker-compose.yaml file from [bardchat-python](https://github.com/thecodekitchen/bardchat-python/blob/master/docker-compose.yaml) and move it into your installation directory. 
run
```
nano ~/.bashrc
```
to edit your startup configuration and add the following alias, assuming your installation is in the home directory and named 'bardchat':
```
alias bard='cd ~/bardchat\nohup bardchat &\docker compose up'
```
You may need to install nohup:
```
sudo apt-get install nohup
```
Now, when you start a new console, you should be able to type 'bard' to open the front end while your console displays the server logs for the back end.

That's all you will need to do from now on to start the app locallly!

##Step 4:
Visit bard.google.com, log in with your google account, and hit F12 on the chat page.
Go to the Storage blade of the Application tab and select https://bard.google.com from the Cookies dropdown.
From there, find the Secure_1PSID cookie and copy its value. This essentially operates as your API token for the moment until an official API is released. More info can be found [here](https://github.com/dsdanielpark/Bard-API).

I recommend saving the token somewhere to copy and paste easily since it is currently needed each time you start the app even though it remains relatively stable for each user for some time. I'm working on a better solution for saving the token, but for now just paste it into the key field.

If you want Bard to be aware of the contents of a specific url, paste it into the context field and press enter to add it to the list that is sent with each request. The back end is configured to send an initialization prompt requesting that Bard review the urls listed in the context and be prepared to answer questions about them before it sends your first question in the conversation.

Currently, it just starts a new conversation every time you close and reopen the app. I'm working on a strategy for saving conversations in a database locally to be retrieved for later re-use.

If you have any questions, contact andy@thecodekitchen.xyz

Thanks!
