db.createUser({
    user: 'mongoadmin',
    pwd: 'secret',
    roles: [
        {
            role: 'readWrite',
            db: 'testDB',
        },
    ],
});

db = new Mongo().getDB("mockdb");

db.createCollection('demo1', { capped: false });
db.createCollection('demo2', { capped: false });

db.test.insert([
    { "item": 1 },
    { "item": 2 },
    { "item": 3 },
    { "item": 4 },
    { "item": 5 }
]);