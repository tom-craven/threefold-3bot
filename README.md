# threefold-3bot
A dockerfile for the threefold 3bot client. Allows access the services and interact with farming nodes.

follow the high level instruction to Get 3Bot Connect App and 3Bot ID
https://manual.threefold.io/#/mainnet_getting_started?id=get-3bot-connect-app-and-3bot-id

- login to docker locally
>docker login 
- run the image straight from dockerhub, alternatively follow the build it yourself instruction. 

>docker run -p 8443:8443 --name threefold-3Bot-local -it tomcraven/threefold-3bot:latest

- and run the command

>poetry shell

- then start the 3bot

>threebot start --local

- Follow the onscreen prompts and Your done! find the 3bot at https://localhost:8443

###Build it yourself
build and run locally
>docker build
 --build-arg USER=1000 --build-arg USER_GROUP=1000
 -t threefold-3bot .
 && docker run
 -p 8443:8443
 --name threefold-3Bot-local
 threefold-3bot 

exec onto the docker and follow the instruction above

>docker exec -i -t threefold-3Bot-local /bin/bash
