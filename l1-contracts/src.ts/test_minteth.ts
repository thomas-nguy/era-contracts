import { ethers } from 'ethers';
import { Provider as ZkSyncProvider, Wallet as ZKWallet } from 'zksync-web3';
import * as dotenv from "dotenv";
const L2_JSON_PROVIDER = "http://localhost:3050";
const DERIVE_PATH = "m/44'/60'/0'/0/1";
const MNEMONIC = "fine music test violin matrix prize squirrel panther purchase material script deal";
const L2ETH_ADDRESS = "0x000000000000000000000000000000000000800a";
import { L2EthTokenFactory } from "../../system-contracts/typechain";

dotenv.config();

const MintGasToken = async () => {
    let wallet = ZKWallet.fromMnemonic(MNEMONIC, DERIVE_PATH);
    const l2Provider = new ZkSyncProvider(L2_JSON_PROVIDER);
    wallet = wallet.connect(l2Provider);
    let balance = await l2Provider.getBalance(wallet.address);
    console.log("ETH balance on l2: ", ethers.utils.formatEther(balance));
    let ethBalance = await l2Provider.getBalance(wallet.address, "latest", L2ETH_ADDRESS);
    console.log("ETH balance on l2 (2): ", ethers.utils.formatEther(ethBalance));

    const ETH = L2EthTokenFactory.connect(L2ETH_ADDRESS, wallet);
    console.log("Mint ETH on l2...");
    let tx = await ETH.mintByAdmin(wallet.address, ethers.utils.parseEther("100"), {
    });

    console.log(tx.confirmations);

    balance = await l2Provider.getBalance(wallet.address);
    console.log("ETH balance on l2: ", ethers.utils.formatEther(balance));
    ethBalance = await l2Provider.getBalance(wallet.address, "latest", L2ETH_ADDRESS);
    console.log("ETH balance on l2 (2): ", ethers.utils.formatEther(ethBalance));
};

MintGasToken();
