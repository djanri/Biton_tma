using Microsoft.EntityFrameworkCore;

[Index(nameof(UserId), AllDescending = true)]
public class Prize
{
    public int Id { get; set; }

    public required string Name { get; set;}

    public string? Description { get; set; }

    public int Cost { get; set; }

    public byte[]? Image { get; set; }

    public required string ChannelUrl { get; set;}

    public required string ChannelName { get; set;}

    public int? UserId {get; set;}
}