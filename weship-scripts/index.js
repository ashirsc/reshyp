const admin = require('firebase-admin')


const serviceAccount = require("./weship-dev-firebase-adminsdk-hxfs1-db5cfa2dcb.json")

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://weship-dev.firebaseio.com"
});

const fs = admin.firestore()

// fs.listCollections().then(result => {
//     result.forEach(col => {
//         console.log(col.id)

//     })
// })



addPickups().then(res => {
    console.log('done')
})

async function addPickups() {

       let proms = []

            for (let i = 0; i < 1; i++) {
                const { dx, dy } = getGeopointVariation()
                let where = new admin.firestore.GeoPoint(40.242435 + dx, -111.655326 + dy)
                let when = Date.now()
                let who = 'drew@gmail.com'
                let what = getRandomItem()
        
                const item = { where, when, what, who }
        
                proms.push(fs.collection('pickups').add(item))
                console.log('added ', item);
        
        
            }

            await Promise.all(proms)     
            return
    
    
}


function getRandomItem() {
    const sizes = ['small', 'medium', 'large']
    return { size: sizes[getRandomInt(3)] }
}

function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

function getGeopointVariation() {
    let dx = Math.random() / 10
    let dy = Math.random() / 10
    if (Math.random() < 0.5)
        dx *= -1
    if (Math.random() < 0.5)
        dy *= -1
    return { dx, dy }
}