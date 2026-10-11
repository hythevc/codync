/// <reference types="vite/client" />
import type { SquadbotsBridge } from '@shared/ipc'

declare global {
  interface Window {
    squadbots: SquadbotsBridge
  }
}

export {}
