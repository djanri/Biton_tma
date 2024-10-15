using Microsoft.EntityFrameworkCore;

public class UserService()
{
    public static async Task<IResult> GetUser(int id, AppDBContext db)
    {
        return await db.Users.FindAsync(id)
                is User user
                    ? TypedResults.Ok(user)
                    : TypedResults.NotFound();
    }

    public static async Task<IResult> CreateUser(User user, AppDBContext db)
    {
        db.Users.Add(user);
        await db.SaveChangesAsync();

        return TypedResults.Created($"/users/{user.Id}", user);
    }

    public static async Task<IResult> UpdateUser(int id, User inputUser, AppDBContext db)
    {
        var user = await db.Users.FindAsync(id);

        if (user is null) return TypedResults.NotFound();

        user.Points = inputUser.Points;
        user.ReferalId = inputUser.ReferalId;
        user.UserId = inputUser.UserId;

        await db.SaveChangesAsync();

        return TypedResults.NoContent();
    }

    public static async Task<IResult> DeleteUser(int id, AppDBContext db)
    {
        if (await db.Users.FindAsync(id) is User user)
        {
            db.Users.Remove(user);
            await db.SaveChangesAsync();
            return TypedResults.NoContent();
        }

        return TypedResults.NotFound();
    }
    
    public static async Task<IResult> GetUserWithPrizes(int id, AppDBContext db)
    {
        return await db.Users.Include(u => u.Prizes).FirstOrDefaultAsync(u => u.Id == id)
                is User user
                    ? TypedResults.Ok(user)
                    : TypedResults.NotFound();
    }

    public static async Task<IResult> GetReferalsCount(int id, AppDBContext db)
    {
        var referalsCount =  await db.Users.CountAsync(us => us.ReferalId == id);
        return TypedResults.Ok(referalsCount);
    }

    public static async Task<IResult> GetRandomUser(AppDBContext db)
    {
        return await db.Users.OrderBy(us => EF.Functions.Random()).FirstAsync()
                is User user
                    ? TypedResults.Ok(user)
                    : TypedResults.NotFound();
    }
}