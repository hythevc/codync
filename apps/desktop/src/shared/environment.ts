/** Installed identities. Production values stay unchanged when adding Squadbots Dev. */
export function environmentProfile(environment: 'main' | 'dev') {
  const dev = environment === 'dev'
  return {
    environment,
    name: dev ? 'Squadbots Dev' : 'Squadbots',
    appId: dev ? 'ai.squadbots.Squadbots.dev' : 'ai.squadbots.Squadbots',
    scheme: dev ? 'squadbots-dev' : 'squadbots',
    dataFolder: dev ? '.squadbots-dev' : '.squadbots',
    port: dev ? 19223 : 19222,
    hostLabel: dev ? 'ai.squadbots.squadbots.ai.host' : 'ai.squadbots.squadbots.host',
    systemdUnit: dev ? 'squadbots-dev-host.service' : 'squadbots-host.service',
    windowsService: dev ? 'SquadbotsDevHost' : 'SquadbotsHost',
    supervisor: dev ? 'squadbots-dev-hostw.exe' : 'squadbots-hostw.exe',
    screenLabel: dev ? 'ai.squadbots.Squadbots.dev.screen' : 'ai.squadbots.Squadbots.screen',
    screenName: dev ? 'SquadbotsDevScreen' : 'SquadbotsScreen',
    releaseUpdates: !dev,
  }
}

/** Refuse to manage a different environment's daemon, including pre-isolation dev hosts. */
export function hostEnvironmentError(expected: 'main' | 'dev', actual?: string): string | null {
  if (actual === expected || (expected === 'main' && actual === undefined)) return null
  return `This ${expected === 'dev' ? 'Squadbots Dev' : 'Squadbots'} app found a host from ${actual ?? 'an unidentified environment'}. Start the matching host on its own port.`
}
