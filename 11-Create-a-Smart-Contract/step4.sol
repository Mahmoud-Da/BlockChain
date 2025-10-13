pragma solidity ^0.4.11;

contract hadcoin_ico {
    // Maximum number of hadcoins available for sale
    uint public max_hadcoins = 1000000;

    // Conversion rate: 1 USD = 1000 hadcoins
    uint public usd_to_hadcoins = 1000;

    // Total number of hadcoins bought by investors
    uint public total_hadcoins_bought = 0;

    // Mapping from investor address to their equity in Atcoins
    mapping(address => uint) equityAtcoins;

    // Mapping from investor address to their equity in USD
    mapping(address => uint) equityUSD;

    modifier canBuyAdCoins(uint usdInvested) {
        require(
            (usdInvested * usd_to_hadcoins + total_hadcoins_bought) <=
                max_hadcoins
        );
        _;
    }
}
