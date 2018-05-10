const Voting = artifacts.require("./Voting.sol");
const utils = require('web3-utils')

contract("Voting.sol", async function(accounts) {

    let voting;
    let proposalId = 1; 
    let vote = 2;
    let voter = accounts[0]

    before("Deploys the contract", async function() {
        voting = await Voting.new();
    });

    it("Submits a commitment and reveals it", async function() {
        let commitment = utils.soliditySha3(proposalId, vote);
        let sig = web3.eth.sign(voter, commitment);
        voting.submitVote(proposalId, commitment)
        // ... some time passes until voting period is done
        voting.revealVote(proposalId, vote, sig);
        voting.Revealed({}, {fromBlock:0, toBlock: 'latest'}).get((error, res) => assert.equal(res[0].args.voter, voter));
    });
});
