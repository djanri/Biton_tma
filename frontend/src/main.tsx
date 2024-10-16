import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.tsx'
import './index.css'
import './mockEnv.ts';
import { init } from './init.ts';
import { retrieveLaunchParams } from '@telegram-apps/sdk-solid';

// Configure all application dependencies.
init(retrieveLaunchParams().startParam === 'debug');

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
