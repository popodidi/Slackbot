# Slackbot 🤖

Slackbot utilizes Swift with Vapor framework to build an swift executable that allows you to customize response of your slackbot by simply setting bot token and adding a few lines of Swift codes.

Feel free to open any issue or pull request.

## Environment

- Swift: 3.0 
- Vapor: 0.14

> It is recommended to use [swiftenv](https://swiftenv.fuller.li) to manage the Swift version.

## Get started

### Clone

```bash
$ git clone https://github.com/popodidi/Slackbot
```

### Generate .xcodeproj (optional but recommended)

```bash
$ swift package generate-xcodeproj
$ open Slackbot.xcodeproj
```

### Set bot token

[Create a bot](https://my.slack.com/services/new/bot) to get token if you don't have one.
Set it up in `/Sources/Config.swift`

```swift
import Foundation

struct Slack {
    struct Config {
    	// set your bot token here
        static let BotToken = "----Your Bot Token----"
        static let SimpleLatest = true
        static let NoUnreads = true
    }
}

```

### Install openssl (for macOS)

```bash 
$ brew install openssl
$ brew link openssl -f
```

### Run

#### Terminal

```bash
$ swift build
$ .build/debug/Slackbot
```

#### Xcode

Choose **Slackbot** scheme and press **Run** button

### Customize response

Check out `/Sources/MyResponseHandler` and follow the instructions written in comments to override the functions.

For example, if you want to respond to a specific message, "how are you?".

```swift
override func response(toMessage text: String) -> String?{
	if text == "how are you?"{
		return "I'm good"
	}else{
		// return nil for no response
		return nil
	}
}
```


## License

Slackbot is freely distributable under the terms of the MIT license.

<!--
## Deploy

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Documentation

View [Vapor](https://github.com/qutheory/vapor) for documentation.

## Requirements

Swift 3.0 preview 2 is required (Xcode 8 beta 2 on macOS). 

Works on Ubuntu, Docker, Heroku, macOS.

Run the following script to check if you have Swift 3.0 beta 2 properly installed and configured.

```
curl -sL check.qutheory.io | bash
```

## Building

Visit [Getting Started](http://docs.qutheory.io) in the documentation.

### Compiling

If you have the [Vapor Toolbox](https://github.com/qutheory/vapor-toolbox), use `vapor new <project-name>` to create your new application.

Then run `vapor build` and `vapor run`.

Otherwise, clone this repo and run `swift build` to compile your application, then run `.build/debug/App`.

### Xcode 8

Run `vapor xcode` which will create the Xcode Project and open Xcode 8.

![Xcode](https://cloud.githubusercontent.com/assets/1342803/15592631/3e740df8-2373-11e6-8624-3c89260322aa.png)

## Deploying

Check the [Vapor](https://github.com/qutheory/vapor) documentation for more in-depth deployment instructions.

### Upstart

To start your `Vapor` site automatically when the server is booted, add this file to your server.

You can check if Upstart is installed with 

```sh
initctl --version
```

You may need to install Upstart if it is not already on your installation of Linux.

```sh
sudo apt-get install upstart
```

`/etc/init/vapor-example.conf`

```conf
description "Vapor Example"

start on startup

env PORT=8080

exec /home/<user_name>/vapor-example/.build/release/App --env=production
```

You additionally have access to the following commands for starting and stopping your server.

```shell
sudo stop vapor-example
sudo start vapor-example
```

The following script is useful for upgrading your website.

```shell
git pull
swift build --configuration release
sudo stop vapor-example
sudo start vapor-example
```

### Heroku

Use the `vapor heroku` commands in the Vapor Toolbox to push to Heroku.

### Docker

You can run this demo application locally in a Linux environment using Docker.

Make sure you have installed the Vapor Toolbox.

1. Ensure [Docker](https://www.docker.com) is installed on your local machine.
2. Start the Docker terminal
3. cd into `vapor-example`
4. Create the Dockerfile `vapor docker init`
5. Build the container `vapor docker build`
6. Run the container `vapor docker run`
7. Optionally enter the container `vapor docker enter`
5. Configure VirtualBox to [forward ports 8080 to 8080](https://www.virtualbox.org/manual/ch06.html)
6. Visit http://0.0.0.0:8080

### Nginx / Supervisor

You can also run your Vapor app through Nginx.  It’s recommended you use [Supervisor](http://supervisord.org) to run the app instance to protect against crashes and ensure it’s always running.

#### Supervisor

To setup Vapor running through Supervisor, follow these steps:

`apt-get install -y supervisor`

Edit the config below to match your environment and place it in `/etc/supervisor/conf.d/your-app.conf`:

```shell
[program:your-app]
command=/path/to/app/.build/release/App serve --ip=127.0.0.1 --port=8080
directory=/path/to/app
user=www-data
stdout_logfile=/var/log/supervisor/%(program_name)-stdout.log
stderr_logfile=/var/log/supervisor/%(program_name)-stderr.log
```

Now register the app with Supervisor and start it up:
```shell
supervisorctl reread
supervisorctl add your-app
supervisorctl start your-app # `add` may have auto-started, so disregard an “already started” error here
```

#### Nginx

With the app now running via Supervisor, you can use this sample nginx config to proxy it through Nginx:

```nginx
server {
	server_name your.host;
	listen 80;

	root /path/to/app/Public;

	# Serve all public/static files via nginx and then fallback to Vapor for the rest
	try_files $uri @proxy;

	location @proxy {
		# Make sure the port here matches the port in your Supervisor config
		proxy_pass http://127.0.0.1:8080;
		proxy_pass_header Server;
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_connect_timeout 3s;
		proxy_read_timeout 10s;
	}
}
```
-->
