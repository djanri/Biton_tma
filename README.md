# Biton_tma
 Telegram bot with mini app

 Contains 3 folders
 1. bot
 2. backend
 3. frontend

#backend
- run db in docker
```docker-compose up -d```

- go to backend folder

```cd .\backend\```

- run commands to enable https

```dotnet tool install -g Microsoft.dotnet-httprepl```
```dotnet dev-certs https --trust```

- to start application run next command

```dotnet run```
```dotnet run --project ./backend```

- to start application with hot reload run command

```dotnet run -watch```

- to publish
```dotnet publish -c Release -o ./build/ --runtime linux-x64```

- copy build files to server


#frontend

- install cert 
```mkcert -install```

- add to hosts file ("c:\Windows\System32\drivers\etc\hosts")
```127.0.0.1 biton-tma.local```

- start app
```npm run dev```

- build app
```npm run build```

- open in browser url https://biton-tma.local


#bot

- go to server and run command(if you didn't it before)
```screen```

-go to bot folder and run
```python test.py```

- Detach from the screen by hitting CTRL + A + D on your keyboard

- to list all screens
```screen -ls```

- To reattach to the screen
```screen -r```

- list all processes
```ps aux```