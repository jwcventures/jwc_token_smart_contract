const JWCToken = artifacts.require('JWCToken');
const IcoContract = artifacts.require('IcoContract');

module.exports = function(deployer) {
  deployer.deploy(JWCToken).then(() => {
    return deployer.deploy(
      IcoContract,
      JWCToken.address
    ).then(() => {
      return JWCToken.deployed().then(function(instance) {
        return instance.setIcoContract(IcoContract.address);
      });
    });
  });
};
