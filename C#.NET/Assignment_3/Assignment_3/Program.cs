public class Program
{

    static void Main(string[] args)
    {
        int[] numbers = GeneraleNumbers();
        Reverse(numbers);
        PrintNumbers(numbers);
    }

    private static int[] GeneraleNumbers()
    {
        int[] numbers = new int[10];
        for (int i = 0; i < numbers.Length; i++)
        {
            numbers[i] = i + 1;
        }
        return numbers;
    }

    private static void Reverse(int[] numbers)
    {
        int length = numbers.Length/2;
        for (int i = 0; i < length; i++)
        {
            int temp = numbers[i];
            numbers[i] = numbers[numbers.Length - 1 - i];
            numbers[numbers.Length - 1 - i] = temp;
        }
    }

    private static void PrintNumbers(int[] numbers)
    {
        foreach (int number in numbers)
        {
            Console.WriteLine(number+' ');
        }
    }
}