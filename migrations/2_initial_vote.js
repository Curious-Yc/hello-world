const Vote = artifacts.require("./Vote.sol");

module.exports = function (deployer) {
  deployer.deploy(Vote,["aaa","bbb","ccc","ddd"]);
};