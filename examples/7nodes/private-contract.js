a = eth.accounts[0]
web3.eth.defaultAccount = a;

// abi and bytecode generated from simplestorage.sol:
// > solcjs --bin --abi simplestorage.sol
var abi = [
	{
			constant: true,
			inputs: [],
			name: 'storedData',
			outputs: [{ name: '', type: 'uint256' }],
			payable: false,
			type: 'function',
	},
	{
			constant: false,
			inputs: [{ name: 'x', type: 'uint256' }],
			name: 'set',
			outputs: [],
			payable: false,
			type: 'function',
	},
	{
			constant: true,
			inputs: [],
			name: 'get',
			outputs: [{ name: 'retVal', type: 'uint256' }],
			payable: false,
			type: 'function',
	},
	{ inputs: [{ name: 'initVal', type: 'uint256' }], payable: false, type: 'constructor' },
];

var bytecode =
	'0x608060405234801561001057600080fd5b5060405161014c38038061014c8339818101604052602081101561003357600080fd5b8101908080519060200190929190505050806000819055505060f28061005a6000396000f3fe6080604052348015600f57600080fd5b5060043610603c5760003560e01c80632a1afcd914604157806360fe47b114605d5780636d4ce63c146088575b600080fd5b604760a4565b6040518082815260200191505060405180910390f35b608660048036036020811015607157600080fd5b810190808035906020019092919050505060aa565b005b608e60b4565b6040518082815260200191505060405180910390f35b60005481565b8060008190555050565b6000805490509056fea265627a7a7231582071458220641ce1095ca69ab227072e250567877902c6b251fda5a4f2c3fec56c64736f6c63430005100032';

var simpleContract = web3.eth.contract(abi);
var simple = simpleContract.new(42, {from:web3.eth.accounts[0], data: bytecode, gas: 0x47b760, privateFor: ["ROAZBWtSacxXQrOe3FGAqJDyJjFePR5ce4TSIzmJ0Bc="]}, function(e, contract) {
	if (e) {
		console.log("err creating contract", e);
	} else {
		if (!contract.address) {
			console.log("Contract transaction send: TransactionHash: " + contract.transactionHash + " waiting to be mined...");
		} else {
			console.log("Contract mined! Address: " + contract.address);
			console.log(contract);
		}
	}
});
