import { Observable, useModel } from '../lib/observable'

export type SignInProvider = 'apple' | 'google'

export interface AccountInfo {
  userId: string
  email: string | null
  avatarURL: string | null
}

/**
 * The Squadbots account (Clerk, through the main process). An account never grants access to a
 * computer by itself: each one still approves this device (spec §4.2).
 */
export class AccountSession extends Observable {
  isBusy = false
  isReady = true
  isConfigured = false
  errorMessage: string | null = null
  user: AccountInfo | null = null
  cloudURL: string | null = null

  get isSignedIn() {
    return this.user !== null
  }

  async start() {
    const state = await window.squadbots.account.state()
    this.apply(state)
    window.squadbots.account.onChange((s) => this.apply(s))
  }

  private apply(s: Awaited<ReturnType<typeof window.squadbots.account.state>>) {
    this.isReady = s.ready
    this.isConfigured = s.configured
    this.isBusy = s.busy
    this.errorMessage = s.error
    this.user = s.user
    this.cloudURL = s.cloudURL
    this.changed()
  }

  async signIn(provider: SignInProvider) {
    await window.squadbots.account.signIn(provider)
  }

  async signOut() {
    await window.squadbots.account.signOut()
  }

  sessionToken() {
    return window.squadbots.account.token()
  }
}

export const account = new AccountSession()

export function useAccount() {
  return useModel(account)
}
