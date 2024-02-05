using System;
using System.Linq;

public class Program
{
    public static void Main()
    {
        Console.WriteLine("Hasil Perkalian Sederhan : " + PerkalianSederhana(5, 4));
    }

    public static int PerkalianSederhana(int j, int k)
    {
        int hasil = 0;
        int total = 0; // Declare total here
        while (j > 0)
        {
            total += k; // Update total here
            j--;
        }
        hasil = total; // Update hasil here
        return hasil;
    }


}

