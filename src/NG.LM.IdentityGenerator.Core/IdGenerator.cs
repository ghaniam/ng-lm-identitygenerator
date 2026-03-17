namespace NG.LM.IdentityGenerator.Core;

public static class IdGenerator
{
    public static string GenerateId(string prefix = "ID")
    {
        return $"{prefix}-{Guid.NewGuid().ToString().ToUpper()}";
    }

    public static string GenerateSequentialId(string prefix = "SEQ")
    {
        var timestamp = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();
        var random = Guid.NewGuid().ToString("N").Substring(0, 8).ToUpper();
        return $"{prefix}-{timestamp}-{random}";
    }
    
    public static int GenerateNumberFromRange(int start, int count)
    {
        return Enumerable.Range(start, count).OrderBy(x => new Random().Next()).First();
    }
}
