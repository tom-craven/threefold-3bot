# threefold-3bot
A dockerfile for the threefold 3bot client. Allows access the services and interact with farming nodes.

follow the high level instruction to Get 3Bot Connect App and 3Bot ID
https://manual.threefold.io/#/mainnet_getting_started?id=get-3bot-connect-app-and-3bot-id

- login to docker locally
>docker login 
- run the image

>docker run --name threefold-3Bot-local -it tomcraven/threefold-3bot:latest

- and run the command

>poetry shell

- then start the 3bot

>threebot start --local

- Follow the onscreen prompts and Your done! find the 3bot at https://localhost:8443
