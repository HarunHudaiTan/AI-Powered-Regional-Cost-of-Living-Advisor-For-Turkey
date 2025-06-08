import { APP_BASE_HREF } from '@angular/common';
import { CommonEngine } from '@angular/ssr';
import express from 'express';
import { fileURLToPath } from 'node:url';
import { dirname, join, resolve } from 'node:path';
import AppServerModule from './src/main.server';
import { createProxyMiddleware } from 'http-proxy-middleware';

// The Express app is exported so that it can be used by serverless Functions.
export function app(): express.Express {
  const server = express();
  const serverDistFolder = dirname(fileURLToPath(import.meta.url));
  const browserDistFolder = resolve(serverDistFolder, '../browser');
  const indexHtml = join(serverDistFolder, 'index.server.html');

  const commonEngine = new CommonEngine();

  server.set('view engine', 'html');
  server.set('views', browserDistFolder);

  // Example Express Rest API endpoints
  // Proxy API requests to backend
  server.use('/api', (req, res, next) => {
    // Forward to Flask backend
    const proxyTarget = 'http://127.0.0.1:5000';
    const options = {
      target: proxyTarget,
      changeOrigin: true,
      secure: false,
    };

    // Create proxy
    const proxy = createProxyMiddleware(options);
    return proxy(req, res, next);
  });

  // Serve static files from /browser (excluding API routes)
  server.use(
    express.static(browserDistFolder, {
      maxAge: '1y',
      index: false, // Don't serve index.html for static files
    })
  );

  // All regular routes use the Angular engine (excluding API routes)
  server.get(/^(?!\/api\/).*/, (req, res, next) => {
    const { protocol, originalUrl, baseUrl, headers } = req;

    commonEngine
      .render({
        bootstrap: AppServerModule,
        documentFilePath: indexHtml,
        url: `${protocol}://${headers.host}${originalUrl}`,
        publicPath: browserDistFolder,
        providers: [{ provide: APP_BASE_HREF, useValue: baseUrl }],
      })
      .then((html) => res.send(html))
      .catch((err) => next(err));
  });

  return server;
}

function run(): void {
  const port = process.env['PORT'] || 4000;

  // Start up the Node server
  const server = app();
  server.listen(port, () => {
    console.log(`Node Express server listening on http://localhost:${port}`);
  });
}

run();
