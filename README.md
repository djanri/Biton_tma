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

- to start application with hot reload run command

```dotnet run -watch```
