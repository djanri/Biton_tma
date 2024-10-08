public class Prize
{
    public int Id { get; set; }

    public required string Name { get; set;}

    public string? Description { get; set; }

    public int Cost { get; set; }

    public byte[]? Image { get; set; }

    public virtual User? Winner { get; set; }
}