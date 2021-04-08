let CrowdFundingWithDeadline = artifacts.require("./CrowdFundingWithDeadline");

contract("CrowdFundingWithDeadline", function (accounts) {
  let contract;
  let contractCreator = accounts[0];
  let beneficiary = accounts[1];

  const ONE_ETH = 1000000000000000000;

  beforeEach(async function () {
    contract = await CrowdFundingWithDeadline.new(
      "funding",
      1,
      10,
      beneficiary,
      {
        from: contractCreator,
        gas: 2000000,
      }
    );
  });

  it("contract is initialized", async function () {
    let campaignName = await contract.name.call();
    expect(campaignName).to.equal("funding");

    let targetAmount = await contract.targetAmount.call();
    expect(targetAmount.toNumber()).to.equal(ONE_ETH);

    // let fundingDeadline = await contract.fundingDeadline.call();
    // expect(fundingDeadline.toNumber()).to.equal(600);

    let Contractbeneficiary = await contract.beneficiaryAddress.call();
    expect(Contractbeneficiary).to.equal(beneficiary);

    let state = await contract.state.call();
    console.log("STATE ==>", state.toNumber());
    expect(state.toNumber()).to.equal(0);
  });
});
