using Microsoft.EntityFrameworkCore;

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

        return TypedResults.Created($"/admins/{admin.UserId}", admin);
    }

    public static async Task<IResult> DeleteAdminByName(string name, AppDBContext db)
    {
        if (await db.Admins.FirstOrDefaultAsync(ad => ad.UserName == name) is Admin admin)
        {
            db.Admins.Remove(admin);
            await db.SaveChangesAsync();
            return TypedResults.NoContent();
        }

        return TypedResults.NotFound();
    }
}