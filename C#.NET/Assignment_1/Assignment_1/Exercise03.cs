namespace Assignment_1;

public class Exercise03
{
   

  
   public static void Fizzbuzz()
    {
        int max = 100;
        for (int i = 0; i < max; i++)
        {
            Console.Write(i);
        }
    }
   public static void PrinAPyramid()
   {
       for (int i = 1; i <= 5; i++)
       {

           // Print stars
           for (int k = 1; k <= (2 * i - 1); k++)
           {
               Console.Write("*");
           }
           Console.WriteLine();
       }
   }

  
    
}