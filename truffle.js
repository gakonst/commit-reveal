const mochaGasSettings = {
  reporter: 'eth-gas-reporter',
  reporterOptions : {
    currency: 'USD',
    gasPrice: 3
  }
}

const mocha = process.env.GAS_REPORTER ? mochaGasSettings : {}

module.exports = {
  networks: {
    rpc: {
      network_id: '*',
      host: 'localhost',
      port: 8545,
      gas: 6283185,
    }
  },
  build: {},
  mocha,
  solc: {
      optimizer: {
          enabled: true,
          runs: 200
      }
  },
}
