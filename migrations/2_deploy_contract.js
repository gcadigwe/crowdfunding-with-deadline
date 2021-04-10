let CrowdFundingWithDeadline = artifacts.require("./CrowdFundingWithDeadline");

module.exports = function (deployer) {
  deployer.deploy(
    CrowdFundingWithDeadline,
    "Test campaign",
    1,
    200,
    "0xBb7BDDA37DcAB91819882C18C53C07f42d6Ac388"
  );
};
