using System;
using System.Linq;

public class Program
{
    public static void Main()
    {
        string kata = "SIAPA";
        string fullstring = "USOMAANAPAIUMASYDNIP";
        int jumlahKata = WordFinder(kata, fullstring);
        Console.WriteLine("Jumlah kata yang dapat dihasilkan: " + jumlahKata);
    }

    public static int WordFinder(string search, string fullstring)
    {
        return search.Min(c => fullstring.Count(ch => ch == c));
    }


}

