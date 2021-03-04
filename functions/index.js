const functions = require('firebase-functions');
const axios = require('axios').default;


exports.getEstimatedShippingPrice = functions.https.onRequest(async (req, res) => {
    const headers = {
        'API-Key': 'TEST_8M61YB54X5ITmfEaDrMBDVAYDF4dQeRRCBbnCLNshyk',
        'Content-Type': 'application/json'
    }

    const params = {
        "carrier_ids": [
            // "se-237512", //usps
            "se-237513", //ups
            "se-237514" //fedex

        ],
        "from_country_code": "US",
        "from_postal_code": "78756",
        "to_country_code": "US",
        "to_postal_code": "95128",
        "to_city_locality": "San Jose",
        "to_state_province": "CA",
        "weight": {
            "value": 1.0,
            "unit": "ounce"
        },
        "dimensions": {
            "unit": "inch",
            "length": 5.0,
            "width": 5.0,
            "height": 5.0
        },
        "confirmation": "none",
        "address_residential_indicator": "no"
    }
    try {

        const res = await axios.post('https://api.shipengine.com/v1/rates/estimate', params, { headers })
        console.log('res', res.data[1])
        res.data.forEach(element => {
            console.log({Carrier: element['carrier_friendly_name'], price: element['shipping_amount'].amount, type: element['service_type']});
            
        });
    } catch (error) {
        console.log(error.response.data)
    }
})

exports.getEstimatedShippingPrice()

exports.helloWorld = functions.https.onRequest((request, response) => {
    response.setHeader('allow-cross-access')
    response.send("Hello from Firebase!");
});
