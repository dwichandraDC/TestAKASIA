class Produk {
    constructor(Nama, countSales) {
        this.Nama = Nama;
        this.countSales = countSales;
    }
}

function Pendapatan(products) {
    const prices = {
        "Ruby": 1000000,
        "Topaz": 1250000,
        "Permata": 3000000
    };

    let totalPendapatan = 0;

    // Calculate the revenue for each type of product
    for (const product of products) {
        const price = prices[product.Nama];
        if (price !== undefined) {
            const Pendapatan = product.countSales * price;
            totalPendapatan += Pendapatan;
        }
    }

    return totalPendapatan;
}

const products = [
    new Produk("Ruby", 5),
    new Produk("Topaz", 3),
    new Produk("Permata", 1)
];

console.log("Total Pendapatan Toko KawanLamaJewel adalah " + Pendapatan(products));
