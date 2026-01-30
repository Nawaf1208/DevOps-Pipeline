const express = require('express');
const app = express();
const port = 3000;
const promClient = require('prom-client');

promClient.collectDefaultMetrics();

app.get('/', (req, res) => {
  res.send('Hello from the DevOps Pipeline App!');
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.get('/metrics', async (req, res) => {
    res.set('Content-Type', promClient.register.contentType);
    res.end(await promClient.register.metrics());
});

app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`);
});