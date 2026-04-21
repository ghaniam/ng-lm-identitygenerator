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
            Assert.Equal(prefix, identifier[..prefix.Length]);
        }
    }
}
