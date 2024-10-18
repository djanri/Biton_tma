using Microsoft.EntityFrameworkCore;

public class PrizeService()
{
    public static async Task<IResult> GetPrize(int id, AppDBContext db)
    {
        return await db.Prizes.FindAsync(id)
                is Prize prize
                    ? TypedResults.Ok(prize)
                    : TypedResults.NotFound();
    }

    public static async Task<IResult> CreatePrize(Prize prize, AppDBContext db)
    {
        db.Prizes.Add(prize);
        await db.SaveChangesAsync();

        return TypedResults.Created($"/prizes/{prize.Id}", prize);
    }

    public static async Task<IResult> UpdatePrize(int id, Prize inputPrize, AppDBContext db)
    {
        var prize = await db.Prizes.FindAsync(id);

        if (prize is null) return TypedResults.NotFound();
        if (prize.UserId == null && inputPrize.UserId != null)
        {
            var user = await db.Users.FindAsync(inputPrize.UserId);
            if (user is not null && user.Points >= inputPrize.Cost)
            {
                user.Points -= inputPrize.Cost;
                prize.UserId = inputPrize.UserId;
            }
        }

        prize.Name = inputPrize.Name;
        prize.Description = inputPrize.Description;
        prize.Cost = inputPrize.Cost;
        prize.Image = inputPrize.Image;
        prize.ChannelUrl = inputPrize.ChannelUrl;
        prize.ChannelName = inputPrize.ChannelName;

        await db.SaveChangesAsync();

        return TypedResults.NoContent();
    }

    public static async Task<IResult> DeletePrize(int id, AppDBContext db)
    {
        if (await db.Prizes.FindAsync(id) is Prize prize)
        {
            db.Prizes.Remove(prize);
            await db.SaveChangesAsync();
            return TypedResults.NoContent();
        }

        return TypedResults.NotFound();
    }

    public static async Task<IResult> GetPrizeByWinnerId(int id, AppDBContext db)
    {
        var prizes = await db.Prizes.Where(p => p.UserId == id).ToListAsync();
        return TypedResults.Ok(prizes);
    }

    public static async Task<IResult> GetPrizeActive(AppDBContext db)
    {
        var prizes = await db.Prizes.Where(p => p.UserId == null).ToListAsync();
        return TypedResults.Ok(prizes);
    }

}