const request = require('supertest');
const app = require('../app.js');

describe('GET /', () => {
  it('should return welcome message', (done) => {
    request(app)
      .get('/')
      .expect(200)
      .expect({ 
        message: 'Hello from Sample App!',
        version: '1.0.0',
        environment: 'development'
      }, done);
  });
});

describe('GET /health', () => {
  it('should return health status', (done) => {
    request(app)
      .get('/health')
      .expect(200)
      .expect(/healthy/, done);
  });
});
