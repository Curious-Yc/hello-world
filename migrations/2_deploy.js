const Logic = artifacts.require("Logic");

module.exports = async function (deployer) {
  await deployer.deploy(Logic);
};