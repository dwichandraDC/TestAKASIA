function wordFinder(search, fullstring) {
    var results = [];

    for (var i = 0; i < search.length; i++) {
        var count = 0;
        for (var j = 0; j < fullstring.length; j++) {
            if (fullstring[j] === search[i]) {
                count++;
            }
        }
        results.push(count);
    }

    var final = Math.min(...results); // Use the spread operator to pass elements as arguments
    return final;
}
var kata = "SIAPA";
var fullstring = "USOMAANAPAIUMASYDNIP";
var jumlahKata = wordFinder(kata, fullstring);
console.log("Jumlah kata yang dapat dihasilkan : " + jumlahKata);


