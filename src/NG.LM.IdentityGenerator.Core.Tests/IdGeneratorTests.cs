namespace NG.LM.IdentityGenerator.Core.Tests
{
    public class IdGeneratorTests
    {
        [Fact]
        public void IdGenerator_ReturnsOk()
        {
            var prefix = "TEST";
            var identifier = IdGenerator.GenerateId(prefix);
            Assert.NotNull(identifier);
            Assert.Equal(prefix, identifier.Substring(0, 4));
        }
        
        [Theory]
        [InlineData("TEST")]
        [InlineData("ID")]
        [InlineData("A")]
        [InlineData("")]
        public void GenerateId_StartsWithPrefix(string prefix)
        {
            var identifier = IdGenerator.GenerateId(prefix);

            Assert.NotNull(identifier);
            Assert.StartsWith($"{prefix}-", identifier);
        }

        [Fact]
        public void GenerateId_UsesDefaultPrefix_WhenNoneProvided()
        {
            var identifier = IdGenerator.GenerateId();

            Assert.StartsWith("ID-", identifier);
        }

        [Theory]
        [InlineData("SEQ")]
        [InlineData("ORDER")]
        [InlineData("X")]
        public void GenerateSequentialId_StartsWithPrefixAndHasThreeParts(string prefix)
        {
            var identifier = IdGenerator.GenerateSequentialId(prefix);

            Assert.NotNull(identifier);
            Assert.StartsWith($"{prefix}-", identifier);

            var parts = identifier.Split('-');
            Assert.Equal(3, parts.Length);
            Assert.True(long.TryParse(parts[1], out _));
            Assert.Equal(8, parts[2].Length);
        }

        [Theory]
        [InlineData(0, 1)]
        [InlineData(0, 10)]
        [InlineData(5, 1)]
        [InlineData(-3, 6)]
        public void GenerateNumberFromRange_ReturnsValueWithinRange(int start, int count)
        {
            var result = IdGenerator.GenerateNumberFromRange(start, count);

            Assert.InRange(result, start, start + count - 1);
        }
    }
}
