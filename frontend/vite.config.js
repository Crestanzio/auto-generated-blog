import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  build  : { outDir: "build" },
  preview: {
    allowedHosts: [
      'ec2-51-21-250-199.eu-north-1.compute.amazonaws.com'
    ],
  },
})
