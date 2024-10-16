public class ChannelService()
{
    public static async Task<IResult> GetChannel(int id, AppDBContext db)
    {
        return await db.Channels.FindAsync(id)
                is Channel channel
                    ? TypedResults.Ok(channel)
                    : TypedResults.NotFound();
    }

    public static async Task<IResult> CreateChannel(Channel channel, AppDBContext db)
    {
        db.Channels.Add(channel);
        await db.SaveChangesAsync();

        return TypedResults.Created($"/channels/{channel.Id}", channel);
    }

    public static async Task<IResult> UpdateChannel(int id, Channel inputChannel, AppDBContext db)
    {
        var channel = await db.Channels.FindAsync(id);

        if (channel is null) return TypedResults.NotFound();

        channel.Name = inputChannel.Name;
        channel.Url = inputChannel.Url;

        await db.SaveChangesAsync();
        return TypedResults.NoContent();
    }

    public static async Task<IResult> DeleteChannel(int id, AppDBContext db)
    {
        if (await db.Channels.FindAsync(id) is Channel channel)
        {
            db.Channels.Remove(channel);
            await db.SaveChangesAsync();
            return TypedResults.NoContent();
        }

        return TypedResults.NotFound();
    }
}