
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

[Index(nameof(UserName), IsUnique = true)]
public class Admin
{
    [Key]
    public int UserId { get; set; }

    public required string UserName { get; set;}

    public required string ChannelUrl { get; set;}
}
