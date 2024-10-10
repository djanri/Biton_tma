public class User
{
    public int Id { get; set; }

    public int UserId { get; set;}

    public required string UserName { get; set;}

    public int ReferalId { get; set; }

    public int Points { get; set; }

    public List<Prize> Prizes { get; } = [];
}