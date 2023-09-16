import { defineConfig } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import tsconfigPaths from "vite-tsconfig-paths";

export default defineConfig({
  plugins: [
    RubyPlugin(),
    tsconfigPaths(),
  ],
})
