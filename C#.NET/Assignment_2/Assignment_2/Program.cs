public class Program
{
    static void Main()
    {
        Console.WriteLine("Enter start number:");
        int startNum = int.Parse(Console.ReadLine());

        Console.WriteLine("Enter end number:");
        int endNum = int.Parse(Console.ReadLine());

        int[] primes = FindPrimesInRange(startNum, endNum);

        Console.WriteLine("Prime numbers in the range:");
        Console.WriteLine(string.Join(", ", primes));
    }

    static void CopyArray()
    {
        String[] array = { "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten" };
        String[] cloneArray = new String[array.Length];
        for (int i = 0; i < array.Length; i++)
        {
            cloneArray[i] = array[i];
        }
    }
    
    static int[] FindPrimesInRange(int startNum, int endNum)
    {
        List<int> primes = new List<int>();

        // Ensure startNum is at least 2 (smallest prime number)
        if (startNum < 2) startNum = 2;

        for (int num = startNum; num <= endNum; num++)
        {
            if (IsPrime(num))
            {
                primes.Add(num);
            }
        }

        return primes.ToArray();
    }

    static bool IsPrime(int number)
    {
        if (number < 2) return false;

        for (int i = 2; i <= Math.Sqrt(number); i++)
        {
            if (number % i == 0) return false;
        }

        return true;
    }
}