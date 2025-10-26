const { request } = require('undici');
const UserAgent = require('user-agents');

const TARGET_URL = 'https://test.zoomov.cat';

setInterval(async () => {
  try {
    const userAgent = new UserAgent().toString();

    const { statusCode, headers, body } = await request(TARGET_URL, {
      headers: {
        'User-Agent': userAgent,
      },
      method: 'GET',
    });

    //console.log(`[${new Date().toISOString()}] ${TARGET_URL} -> ${statusCode}`);
  } catch (err) {
    //console.error('İstek hatası:', err.message);
  }
}, 0);
