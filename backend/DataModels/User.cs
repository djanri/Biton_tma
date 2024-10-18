using Microsoft.EntityFrameworkCore;

public class User
{
    public int UserId { get; set;}

    public required string UserName { get; set;}

    public int ReferalId { get; set; }

    public int Points { get; set; }

    public List<Prize> Prizes { get; } = [];
}