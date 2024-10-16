public class AdminService()
{
    public static async Task<IResult> GetAdmin(int id, AppDBContext db)
    {
        return await db.Admins.FindAsync(id)
                is Admin admin
                    ? TypedResults.Ok(admin)
                    : TypedResults.NotFound();
    }

    public static async Task<IResult> CreateAdmin(Admin admin, AppDBContext db)
    {
        db.Admins.Add(admin);
        await db.SaveChangesAsync();

        return TypedResults.Created($"/admins/{admin.Id}", admin);
    }

    public static async Task<IResult> UpdateAdmin(int id, Admin inputAdmin, AppDBContext db)
    {
        var admin = await db.Admins.FindAsync(id);

        if (admin is null) return TypedResults.NotFound();

        admin.UserName = inputAdmin.UserName;
        admin.ChannelUrl = inputAdmin.ChannelUrl;

        await db.SaveChangesAsync();
        return TypedResults.NoContent();
    }

    public static async Task<IResult> DeleteAdmin(int id, AppDBContext db)
    {
        if (await db.Admins.FindAsync(id) is Admin admin)
        {
            db.Admins.Remove(admin);
            await db.SaveChangesAsync();
            return TypedResults.NoContent();
        }

        return TypedResults.NotFound();
    }
}