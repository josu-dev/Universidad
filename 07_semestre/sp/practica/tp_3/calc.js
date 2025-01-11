const secuentials = [
    // 0.440518, 3.518575, 27.995801, 225.164102,
    0.440518, 3.518575, 27.995801, 225.164102,
    0.440518, 3.518575, 27.995801, 225.164102,
]

const ps = [
    // 8, 8, 8, 8,
    16, 16, 16, 16,
    32, 32, 32, 32,
]

const totals = [
    0.104850,0.523410,2.994466,20.336543,0.108402,0.469726,2.282568,13.114073,

]
const comms = [
    0.069081,0.283189,1.222254,4.993339,0.082422,0.331216,1.324375,5.541022,

]

if (totals.length !== comms.length) {
    throw new Error("Length of totals and comms must be equal")
}

let toPrint = ""

// speed up
let res = totals.map((total, i) => (secuentials[i] / total));

for (let i = 0; i < res.length; i++) {
    toPrint += res[i].toFixed(6) + " "
    if (i > 0 && (i % 4) === 3) {
        console.log(toPrint)
        toPrint = ""
    }
}
console.log();

// efficiency
res = res.map((total, i) => (total / ps[i]));

for (let i = 0; i < res.length; i++) {
    toPrint += res[i].toFixed(6) + " "
    if (i > 0 && (i % 4) === 3) {
        console.log(toPrint)
        toPrint = ""
    }
}
console.log();

// communication overhead
res = totals.map((total, i) => (comms[i] / total) * 100);

for (let i = 0; i < res.length; i++) {
    toPrint += res[i].toFixed(6) + " "
    if (i > 0 && (i % 4) === 3) {
        console.log(toPrint)
        toPrint = ""
    }
}
console.log();
