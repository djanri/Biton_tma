using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class ChangePrizeRelationship : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Prizes_Users_WinnerId",
                table: "Prizes");

            migrationBuilder.RenameColumn(
                name: "WinnerId",
                table: "Prizes",
                newName: "UserId");

            migrationBuilder.RenameIndex(
                name: "IX_Prizes_WinnerId",
                table: "Prizes",
                newName: "IX_Prizes_UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Prizes_Users_UserId",
                table: "Prizes",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Prizes_Users_UserId",
                table: "Prizes");

            migrationBuilder.RenameColumn(
                name: "UserId",
                table: "Prizes",
                newName: "WinnerId");

            migrationBuilder.RenameIndex(
                name: "IX_Prizes_UserId",
                table: "Prizes",
                newName: "IX_Prizes_WinnerId");

            migrationBuilder.AddForeignKey(
                name: "FK_Prizes_Users_WinnerId",
                table: "Prizes",
                column: "WinnerId",
                principalTable: "Users",
                principalColumn: "Id");
        }
    }
}
