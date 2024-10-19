using Microsoft.EntityFrameworkCore;

const string MyAllowSpecificOrigins = "forbitontmalocalhost";

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddPolicy(name: MyAllowSpecificOrigins,
    builder =>
    {
        builder.WithOrigins(
            "https://biton-tma.local:443", 
            "https://biton-tma.local",
            "http://localhost",
            "https://localhost")
            .AllowAnyHeader()
            .AllowAnyMethod();
    });
});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<AppDBContext>(options =>
{
    options
        .UseMySql(connectionString, ServerVersion.AutoDetect(connectionString))
        .LogTo(Console.WriteLine, LogLevel.Information)
        .EnableSensitiveDataLogging()
        .EnableDetailedErrors();
});
builder.Services.AddDatabaseDeveloperPageExceptionFilter();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddOpenApiDocument(config =>
{
    config.DocumentName = "BiTON API";
    config.Title = "BiTON API v1";
    config.Version = "v1";
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseOpenApi();
    app.UseSwaggerUi(config =>
    {
        config.DocumentTitle = "BiTON API";
        config.Path = "/swagger";
        config.DocumentPath = "/swagger/{documentName}/swagger.json";
        config.DocExpansion = "list";
    });
}

app.UseCors(MyAllowSpecificOrigins);

app.UseHttpsRedirection();

var userItems = app.MapGroup("/users");
userItems.MapGet("/{id}", UserService.GetUser);
userItems.MapPost("/", UserService.CreateUser);
userItems.MapPut("/{id}", UserService.UpdateUser);
userItems.MapDelete("/{id}", UserService.DeleteUser);

userItems.MapGet("/random", UserService.GetRandomUser);
userItems.MapGet("/ids", UserService.GetAllUserIds);
userItems.MapGet("/referals-count/{id}", UserService.GetReferalsCount);

var prizeItems = app.MapGroup("/prizes");
prizeItems.MapGet("/{id}", PrizeService.GetPrize);
prizeItems.MapPost("/", PrizeService.CreatePrize);
prizeItems.MapPut("/{id}", PrizeService.UpdatePrize);
prizeItems.MapDelete("/{id}", PrizeService.DeletePrize);

prizeItems.MapGet("/winner/{id}", PrizeService.GetPrizeByWinnerId);
prizeItems.MapGet("/active", PrizeService.GetPrizeActive);

var adminItems = app.MapGroup("/admins");
adminItems.MapGet("/{id}", AdminService.GetAdmin);
adminItems.MapPost("/", AdminService.CreateAdmin);
adminItems.MapDelete("/{name}", AdminService.DeleteAdminByName);


var chnnelItems = app.MapGroup("/channels");
chnnelItems.MapGet("/{id}", ChannelService.GetChannel);
chnnelItems.MapPost("/", ChannelService.CreateChannel);
chnnelItems.MapPut("/{id}", ChannelService.UpdateChannel);
chnnelItems.MapDelete("/{id}", ChannelService.DeleteChannel);

chnnelItems.MapGet("/", ChannelService.GetChannels);


app.MapGet("/", () => "Hello World!");

app.Run();
