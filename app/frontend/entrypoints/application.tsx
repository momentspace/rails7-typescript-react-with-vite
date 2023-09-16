// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
console.log('Vite ⚡️ Rails')
console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

import { createRoot } from 'react-dom/client';
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { Root } from "../routes/root";
import { Test2 } from "../routes/test2";
import { Test1 } from "../routes/test1";
import React from 'react';

const router = createBrowserRouter([
  {
    path: "/home",
    element: <Root />,
    errorElement: "Error",
    children: [
      {
        path: "test1",
        element: <Test1 />
      },
      {
        path: "test2",
        element: <Test2 />
      },

    ],
  },
]);

const rootElement = document.getElementById("root");
if (rootElement === null) throw new Error("rootElement was not found.");

createRoot(rootElement).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);