using System;
using System.Collections.Generic;

public class Produk
{
    public string Nama { get; set; }
    public int countSales { get; set; }
}

public class Program
{
    public static void Main()
    {
        var products = new List<Produk>
        {
            new Produk { Nama = "Ruby", countSales = 5 },
            new Produk { Nama = "Topaz", countSales = 3 },
            new Produk { Nama = "Permata", countSales = 1 }
        };

        Console.WriteLine("TotalPendapatan Toko KawanLamaJewel adalah " +Pendapatan(products));
    }

    public static int Pendapatan(List<Produk> requestParam)
    {
        Dictionary<string, int> prices = new Dictionary<string, int>
        {
            { "Ruby", 1000000 },
            { "Topaz", 1250000 },
            { "Permata", 3000000 }
        };

        int totalPendapatan = 0;

        // Calculate the revenue for each type of product
        foreach (var product in requestParam)
        {
            if (prices.TryGetValue(product.Nama, out int price))
            {
                int Pendapatan = product.countSales * price;
                totalPendapatan += Pendapatan;
            }
        }

        return totalPendapatan;
    }

}
